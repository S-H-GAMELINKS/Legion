require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require_relative 'input'
require_relative 'mastodon'

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])

font = Font.new(18)

x, y = 0, 0

home_timeline = Hash.new

i = 0

Window.caption=("Legion is Mastodon Client")

WAIT = 99999999999999

Window.loop do

    if Input.key_release?(K_RETURN) then
        message = Toot("")
        if message != "" then
            response = client.create_status(message.encode("UTF-8"))
        end
    end
    
    if i % WAIT == 0 then
        home_timeline = GetHomeTimeline(client)

        for num in 0..10
            #Window.draw_font(0, 30 * num, "#{home_timeline[num].account.username}", font)
            Window.draw_font(0, 60 * num, "#{home_timeline[num].content}", font)
        end
    else
        i += 1
    end

    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end