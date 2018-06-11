require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require_relative 'input'
require_relative 'mastodon'

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])

mastodon = MastodonAPI.new(client)

Window.caption=("Legion is Mastodon Client")

Window.loop do

    mastodon.GetHomeTimeline
    mastodon.DrawHomeTimeline

    if Input.key_release?(K_RETURN) then
        message = Toot("")
        if message != "" && message != nil then
            response = client.create_status(message.encode("UTF-8"))
        end
    end

    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end