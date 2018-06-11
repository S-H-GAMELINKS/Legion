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

            toot = Nokogiri::HTML.parse(@timeline[num].content, nil, nil).search('p')
            toot.search('br').each do |br|
                br.replace('br')
            end

            Window.draw_font(0, 60 * num + 20, "#{@timeline[num].account.username}", @font)
            Window.draw_font(0, 60 * num + 40, "#{toot.text}", @font)
        end
    end
end