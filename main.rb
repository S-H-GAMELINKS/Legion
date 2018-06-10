require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require_relative 'input'

URL = UrlInputForm("https://mstdn.jp")
TOKEN = TokenInputForm("")

client = Mastodon::REST::Client.new(base_url: "#{URL}", bearer_token: "#{TOKEN}")

Window.loop do


    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end