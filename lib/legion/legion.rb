require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'mastodon'
require_relative 'ui'

def LegionLoop

window = TkToplevel.new do   #タイトルバーの表示
    title( "Legion" )
end

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
mastodon = MastodonAPI.new(client)

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
streaming = MastodonStreaming.new(stream)

tootFrame = TootFrame.new(window, mastodon)
tootFrame.set

home_timeline = Timeline.new(window, "ホームタイムライン")
home_timeline.set

local_timeline = Timeline.new(window, "ローカルタイムライン")
local_timeline.set

public_timeline = Timeline.new(window, "連合タイムライン")
public_timeline.set

loop do
	Parallel.each([[1, home_timeline, home_timeline.list], [2, local_timeline, local_timeline.list], [3, public_timeline, public_timeline.list]], in_threads: 3) do |call|
		streaming.Timeline(call)
	end
end
end