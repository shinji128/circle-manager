class EventsController < ApplicationController
  def new
    @circle = Circle.find(params[:circle_id])
    @event = Event.new
  end

  def create
    @circle = Circle.find(params[:circle_id])
    @event = @circle.events.new(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :place, :event_fee, :people_limit_num, :limit_answer_at, :note)
  end
end
