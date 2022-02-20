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
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @circle = @event.circle
    @attendance = Attendance.new
  end

  private

  def event_params
    params.require(:event_form).permit(:name, :place, :event_fee, :people_limit_num, :event_at, :event_time, :limit_answer_at, :note, [event_role: [:name, :user_id]]).merge(circle_id: @circle.id)
  end
end
