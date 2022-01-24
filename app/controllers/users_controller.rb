class UsersController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        @user = User.new
        @user.line_user_id = event['source']['userId']
        @user.save
      end
    end
  end

  def new; end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.dig(:line, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    end
  end
end
