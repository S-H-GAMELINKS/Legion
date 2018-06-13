require 'nokogiri'
require 'open-uri'
require 'rmagick'

class MastodonAPI

    def initialize(client)
        @client = client
        @timeline = Hash.new
        @avatar = Array.new
    end

    def Toot(message)
        message += "\n #Legion"
        response = @client.create_status(message.encode("UTF-8"))
    end
end