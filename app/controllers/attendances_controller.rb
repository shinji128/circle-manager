class AttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @attendance = current_user.attendances.new(attendance_params)
    if @attendance.save
      redirect_to request.referer
    else
      render :new
    end
  end

  private
  def attendance_params
    params.require(:attendance).permit(:state, :comment).merge(event_id: @event.id)
  end
end
