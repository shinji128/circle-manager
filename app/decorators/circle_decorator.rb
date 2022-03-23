# frozen_string_literal: true

module CircleDecorator
  def established
    "#{created_at.strftime("%Y-%m-%d")} 設立"
  end
end
