require 'nokogiri'
require 'open-uri'

class MastodonAPI

    def initialize(client)
        @client = client
        @timeline = Hash.new
        @font = Font.new(18)
        @avatar = Array.new
    end

    def GetAvatar(url)
        open(url) {|f|
            File.open("/avatar/avatar.png","wb") do |file|
                file.puts f.read
            end
        }

        Sprite.new(20, 20, Image.load("/avatar/avatar.png"))
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

            @avatar[num] = GetAvatar("#{@timeline[num].account.avatar}")
            @avatar[num].x, @avatar[num].y = 0, 60 * num + 20
            @avatar[num].draw

            Window.draw_font(0, 60 * num + 40, "#{toot.text}", @font)
        end
    end
end