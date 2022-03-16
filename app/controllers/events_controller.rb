class EventsController < ApplicationController

  def circle_events
    @circle = Circle.find(params[:id])
    if @circle.affiliation_user.include?(current_user)
      @events = @circle.events.order(event_at: :desc)
    else
      flash.now[:notice] = 'サークルメンバーだけが閲覧できます'
    end
  end

  def new
    @circle = Circle.find(params[:circle_id])
    @event_form = EventForm.new
  end

  def create
    @circle = Circle.find(params[:circle_id])
    @event_form = EventForm.new(event_params)
    if @event_form.save
      redirect_to circle_event_path(@circle, @event_form.event)
    else
      render :new
    end
  end

  def edit
    @circle = Circle.find(params[:circle_id])
    @event = @circle.events.find(params[:id])
    redirect_to circle_path(@circle) if !@circle.circle_member?(current_user)
    @event_form = EventForm.new(event: @event)
  end

  def update
    @circle = Circle.find(params[:circle_id])
    @event = @circle.events.find(params[:id])
    redirect_to circle_event_path(@circle, @event) if !@circle.circle_member?(current_user)
    @event_form = EventForm.new(event_params, event: @event)
    if params[:event][:event_roles_ids]
      params[:event][:event_roles_ids].each do |event_role_id|
        event_role = @event.event_roles.find(event_role_id)
        event_role.destroy
      end
    end
    if @event_form.update
      redirect_to circle_event_path(@circle, @event)
    else
      render :edit
    end
  end

  def show
    @event = Event.find(params[:id])
    @circle = @event.circle
    @attendance = Attendance.new
    @set_attendance = Attendance.find_by(user_id: current_user.id, event_id: @event.id)
  end

  def shuffle
    @event = Event.find(params[:id])
    @members = {}
    member_id = 1
    @event.attendances.absent.each do |i|
      hoge = { member_id => { 'name' => i.user.name, 'play_count' => 0 } }
      @members.merge!(hoge)
      member_id += 1
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :event_fee, :people_limit_num, :event_at, :event_time, :limit_answer_at, :note, [event_role: [:name, :user_id]]).merge(circle_id: @circle.id)
  end
end
