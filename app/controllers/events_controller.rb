class EventsController < ApplicationController
  def index
    events = []
    current_user.affiliation_circles.each do |circle|
      circle.events.each do |event|
        events << event
      end
    end
    @events = events.sort { |a, b| a.created_at <=> b.created_at }.reverse
  end

  def circle_events
    @circle = Circle.find(params[:id])
    redirect_to circle_path(@circle) unless current_user.circle_member?(@circle)
    @events = @circle.events.order(event_at: :desc)
  end

  def new
    @circle = Circle.find(params[:circle_id])
    @event_form = EventForm.new
  end

  def create
    @circle = Circle.find(params[:circle_id])
    redirect_to circle_path(@circle) unless current_user.circle_member?(@circle)
    @event_form = EventForm.new(event_params)
    if @event_form.save
      redirect_to event_path(@event_form.event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    @circle = @event.circle
    redirect_to circle_path(@circle) unless current_user.circle_member?(@circle)
    @event_form = EventForm.new(event: @event)
  end

  def update
    @event = Event.find(params[:id])
    @circle = @event.circle
    redirect_to circle_path(@circle) unless current_user.circle_member?(@circle)
    @event_form = EventForm.new(event_params, event: @event)
    if params[:event][:event_roles_ids]
      params[:event][:event_roles_ids].each do |event_role_id|
        event_role = @event.event_roles.find(event_role_id)
        event_role.destroy
      end
    end
    if @event_form.update
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def show
    @event = Event.find(params[:id])
    @circle = @event.circle
    redirect_to circle_path(@circle) unless current_user.circle_member?(@circle)
    @attendance = Attendance.find_by(user_id: current_user.id, event_id: @event.id) || Attendance.new
  end

  def destroy
    event = Event.find(params[:id])
    redirect_to circle_path(event.circle) unless current_user.circle_member?(event.circle)
    event.destroy!
    redirect_to circle_event_list_path(event.circle), notice: '?????????????????????????????????'
  end

  def shuffle
    @event = Event.find(params[:id])
    @circle = @event.circle
    redirect_to circle_path(event.circle) unless current_user.circle_member?(@circle)
    @members = {}
    member_id = 1
    @event.attendances.absent.each do |i|
      member = { member_id => { 'name' => i.user.name, 'play_count' => 0, 'member_id' => member_id } }
      @members.merge!(member)
      member_id += 1
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :event_fee, :people_limit_num, :event_at, :event_time, :limit_answer_at, :note, [event_role: %i[name user_id]]).merge(circle_id: @circle.id)
  end
end
