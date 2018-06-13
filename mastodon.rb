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

        if file_path != nil then
            @media_id = @client.upload_media(file_path).id
        else
            @media_id = nil
        end
    end

    def Toot(message)
        message += "\n #Legion"
        response = @client.create_status(message.encode("UTF-8"), :media_ids => @media_id)
    end
end

class MastodonStreaming

    def initialize(stream)
        @stream = stream
    end

    def HomeTimeline(window)
        @stream.user() do |toot|
            htl =TkMessage.new(window, 'text' => toot.content)
            htl.pack
        end
    end

    def PublicTimeline(window)
        @stream.firehose() do |toot|
            ftl = TkMessage.new(window, 'text' => toot.content)
            ftl.pack('side' => 'left', 'fill' => 'both')
        end
    end

    def LocalTimeline(window)
        @stream.firehose()) do |toot|
            ltl = TkMessage.new(window, 'text' => toot.content)
            ltl.pack('side' => 'left', 'fill' => 'both')
        end
    end
end