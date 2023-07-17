# frozen_string_literal: true

require 'skyfall'
require_relative './lib/omikuji'
require_relative './lib/bluesky'

sky = Skyfall::Stream.new('bsky.social', :subscribe_repos)

sky.on_message do |m|
  next if m.type != :commit

  m.operations.each do |op|
    next unless op.action == :create && op.type == :bsky_post

    if op.raw_record['text'] == '@omikuji.bsky.social おみくじ'
      bluesky = Bluesky.new
      bluesky.reply(op.uri, Omikuji.draw)
    end
  end
end

sky.on_connect { puts 'Connected' }
sky.on_disconnect { puts 'Disconnected' }
sky.on_error { |e| puts "ERROR: #{e}" }

sky.connect
sleep
