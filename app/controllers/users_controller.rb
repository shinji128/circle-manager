class UsersController < ApplicationController
  protect_from_forgery except: [:callback]

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.dig(:line, :channel_id)
      config.channel_secret = Rails.application.credentials.dig(:line, :channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :channel_token)
    end
  end
end
