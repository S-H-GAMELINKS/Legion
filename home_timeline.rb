require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'input'
require_relative 'mastodon'

TkRoot.new do   #タイトルバーの表示
    title( "Legion" )
end

Dotenv.load

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
streaming = MastodonStreaming.new(stream)

timeline_window = TkToplevel.new
timeline_window.title('ホームタイムライン')
streaming.HomeTimeline(timeline_window)