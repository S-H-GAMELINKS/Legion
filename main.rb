require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require_relative 'input'

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])

Window.loop do

    if Input.key_push?(K_RETURN) then
        message = TokenInputForm("")
        if message != "" then
            response = client.create_status(message.encode("UTF-8"))
        end
    end

    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end