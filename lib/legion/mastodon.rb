require 'nokogiri'
require 'open-uri'
require 'rmagick'

class MastodonAPI

    def initialize(client)
        @client = client
        @timeline = Hash.new
        @avatar = Array.new
        @media_id = Array.new
    end

    def MediaUpload(file_path)

        if file_path != nil then
            for i in 0...@client.count do
                @media_id[i] = @client[i].upload_media(file_path).id
            end
        else
            @media_id.clear
        end
    end

    def Toot(message, options)
        message += "\n #Legion"

        for i in 0...@client.count do
            response = @client[i].create_status(message.encode("UTF-8"), :media_ids => @media_id[i],
                                                 :visibility => options[:visibility], :sensitive => options[:sensitive], 
                                                 :spoiler_text => options[:spoiler_text])
        end

        @media_id.clear
    end
end

class MastodonStreaming
    attr_accessor :stream, :num

    def initialize(stream, url)
        @stream = stream
        @url    = url
        @num    = 0
    end

    def HomeTimeline(window, list)
        @stream[@num].user() do |toot|
            message = Nokogiri::HTML.parse(toot.content, nil, nil).search('p')
            list.insert('0', "#{toot.account.display_name} さん : #{message.text}")
        end
    end

    def PublicTimeline(window, list)
        @stream[@num].firehose() do |toot|
            message = Nokogiri::HTML.parse(toot.content, nil, nil).search('p')
            list.insert('0', "#{toot.account.display_name} さん : #{message.text}")
        end
    end

    def LocalTimeline(window, list)
        @stream[@num].firehose() do |toot|
            puts @url[@num]
            if toot.uri.to_s =~ /#{@url[@num]}/ then
                message = Nokogiri::HTML.parse(toot.content, nil, nil).search('p')
                list.insert('0', "#{toot.account.display_name} さん : #{message.text}")
            end
        end
    end

    def Timeline(timeline)

        case timeline[0]

        when 1
            self.HomeTimeline(timeline[1], timeline[2])

        when 2
            self.LocalTimeline(timeline[1], timeline[2])

        when 3
            self.PublicTimeline(timeline[1], timeline[2])
        end
    end
end