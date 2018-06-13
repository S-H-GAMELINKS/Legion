require 'nokogiri'
require 'open-uri'
require 'rmagick'

class MastodonAPI

    def initialize(client)
        @client = client
        @timeline = Hash.new
        @avatar = Array.new
        @media_id = nil
    end

    def MediaUpload(file_path)
        @media_id = @client.upload_media(file_path).id
    end

    def Toot(message)
        message += "\n #Legion"
        response = @client.create_status(message.encode("UTF-8"), :media_ids => @media_id)
    end
end