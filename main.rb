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
Window.resize(800, 640)

count = 0

Window.loop do

    if Input.key_push?(K_RETURN) then
        message = Toot("")
        if message != "" && message != nil then
            response = client.create_status(message.encode("UTF-8"))
        end
    end

    if count % 9999999999 == 0 then 
        mastodon.GetHomeTimeline
        mastodon.DrawHomeTimeline
    else
        count += 1
    end

    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end