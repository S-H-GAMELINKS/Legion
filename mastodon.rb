require 'nokogiri'

class MastodonAPI

    def initialize(client)
        @client = client
        @timeline = Hash.new
        @font = Font.new(18)
    end

    def GetHomeTimeline
        i = 0

        @client.home_timeline.each do |toot|
            @timeline[i] = toot
            i += 1
        end
    end

    def DrawHomeTimeline
        for num in 0..5

            toot = Nokogiri::HTML.parse(@timeline[num].content, nil, nil)

            Window.draw_font(0, 30 * num, "#{@timeline[num].account.username}", @font)
            Window.draw_font(0, 60 * num, "#{toot.search('p').text.gsub(/<br>/, "\n")}", @font)
        end
    end
end