require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require_relative 'input'

URL = UrlInputForm("https://mstdn.jp")
TOKEN = TokenInputForm("")

client = Mastodon::REST::Client.new(base_url: "#{URL}", bearer_token: "#{TOKEN}")

response = client.create_status("test toot for legion")