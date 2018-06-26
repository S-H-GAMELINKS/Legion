require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'mastodon'
require_relative 'ui'

def LegionLoop

window = TkRoot.new do   #タイトルバーの表示
    title( "Legion" )
end

Dotenv.load

client = Array.new

url = ENV["MASTODON_URL"].split(",")
token = ENV["MASTODON_TOKEN"].split(",")

for i in 0..url.count do 
	client[i] = Mastodon::REST::Client.new(base_url: url[i], bearer_token: token[i])
end

mastodon = MastodonAPI.new(client)

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
streaming = MastodonStreaming.new(stream)

tootFrame = TootFrame.new(window, mastodon)
tootFrame.set

home_timeline = Timeline.new(window, "ホームタイムライン")
home_timeline.set

home_timeline_yscrollbar = TkScrollbar.new(home_timeline.list) {orient "vertical"; command proc{|*args| home_timeline.list.yview(*args);} }
home_timeline.list['yscrollcommand'] = proc{|*args| home_timeline_yscrollbar.set(*args);}
home_timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')

home_timeline_xscrollbar = TkScrollbar.new(home_timeline.list) {orient "horizontal"; command proc{|*args| home_timeline.list.xview(*args);} }
home_timeline.list['xscrollcommand'] = proc{|*args| home_timeline_xscrollbar.set(*args);}
home_timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')

local_timeline = Timeline.new(window, "ローカルタイムライン")
local_timeline.set

local_timeline_yscrollbar = TkScrollbar.new(local_timeline.list) {orient "vertical"; command proc{|*args| local_timeline.list.yview(*args);} }
local_timeline.list['yscrollcommand'] = proc{|*args| local_timeline_yscrollbar.set(*args);}
local_timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')

local_timeline_xscrollbar = TkScrollbar.new(local_timeline.list) {orient "horizontal"; command proc{|*args| local_timeline.list.xview(*args);} }
local_timeline.list['xscrollcommand'] = proc{|*args| local_timeline_xscrollbar.set(*args);}
local_timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')

public_timeline = Timeline.new(window, "連合タイムライン")
public_timeline.set

public_timeline_yscrollbar = TkScrollbar.new(public_timeline.list) {orient "vertical"; command proc{|*args| public_timeline.list.yview(*args);} }
public_timeline.list['yscrollcommand'] = proc{|*args| public_timeline_yscrollbar.set(*args);}
public_timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')

public_timeline_xscrollbar = TkScrollbar.new(public_timeline.list) {orient "horizontal"; command proc{|*args| public_timeline.list.xview(*args);} }
public_timeline.list['xscrollcommand'] = proc{|*args| public_timeline_xscrollbar.set(*args);}
public_timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')


t1 = Thread.start {
	loop do
		Parallel.each([[1, home_timeline, home_timeline.list], [2, local_timeline, local_timeline.list], [3, public_timeline, public_timeline.list]], in_threads: 3) do |call|
			streaming.Timeline(call)
		end
	end
}

Tk.mainloop

end