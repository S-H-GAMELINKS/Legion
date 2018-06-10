require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require_relative 'input'

url = UrlInputForm("https://mstdn.jp")
token = TokenInputForm("")

client = Mastodon::REST::Client.new(base_url: "#{url}", bearer_token: "#{token}")

Window.loop do


    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end