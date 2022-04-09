# frozen_string_literal: true

module EventDecorator
  require "date"

  def event_start_day
    "#{event_at.strftime("%Y-%m-%d")}"
  end

  def event_start_time
    "#{event_time.strftime("%H:%M")}"
  end

  def limit_ans_at
    "#{limit_answer_at.strftime("%Y-%m-%d")}"
  end
end