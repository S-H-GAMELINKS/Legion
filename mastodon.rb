def GetHomeTimeline(client)

    home_timeline = Hash.new

    i = 0

    client.home_timeline.each do |toot|
        home_timeline[i] = toot
        i += 1
    end

    return home_timeline
end
