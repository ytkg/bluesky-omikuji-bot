# frozen_string_literal: true

require 'bskyrb'

class Bluesky
  def initialize
    @client = client
  end

  def reply(uri, message)
    @client.create_reply(uri, message)
  end

  private

  def client
    credentials = Bskyrb::Credentials.new(ENV['BLUESKY_USERNAME'], ENV['BLUESKY_PASSWORD'])
    session = Bskyrb::Session.new(credentials, 'https://bsky.social')
    Bskyrb::RecordManager.new(session)
  end
end
