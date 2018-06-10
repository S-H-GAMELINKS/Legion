require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require_relative 'input'

URL = UrlInputForm("https://gamelinks007.net")
TOKEN = TokenInputForm("")

client = Mastodon::REST::Client.new(base_url: "#{URL}", bearer_token: "#{TOKEN}")

message = TokenInputForm("")

response = client.create_status(message.encode("UTF-8"))