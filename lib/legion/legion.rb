require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'mastodon'
require_relative 'ui'

def LegionLoop

window = TkToplevel.new do   #タイトルバーの表示
    title( "Legion" )
end

Dotenv.load

tootFrame = TkFrame.new(window)
tootFrame.pack('side' => 'left', 'fill' => 'both')

home_timeline = Timeline.new(window, "ホームタイムライン")
home_timeline.timeline_pack
home_timeline.label_pack
home_timeline.list_pack
home_timeline.y_scrollbar
home_timeline.x_scrollbar

local_timeline = Timeline.new(window, "ローカルタイムライン")
home_timeline.timeline_pack
home_timeline.label_pack
home_timeline.list_pack
home_timeline.y_scrollbar
home_timeline.x_scrollbar

public_timeline = Timeline.new(window, "連合タイムライン")

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
mastodon = MastodonAPI.new(client)

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
streaming = MastodonStreaming.new(stream)

visibility = TkVariable.new('public')
sensitive = TkVariable.new('false')
spoiler_text = TkVariable.new("")

text = TkText.new(tootFrame, 'width' => '50', 'height'=> '30')
text.pack('side' => 'top', 'fill' => 'both')

button = TkButton.new(tootFrame, 'text' => 'toot', 
		       'command' => proc{mastodon.Toot(text.value, visibility.value, sensitive.value, spoiler_text.value);text.value=""})
button.pack('side' => 'left', 'fill' => 'both')

mediabutton = TkButton.new(tootFrame, 'text' => 'media', 
		       'command' => proc{mastodon.MediaUpload(Tk.getOpenFile)})
mediabutton.pack('side' => 'left', 'fill' => 'both')

public_button = TkButton.new(tootFrame, 'text' => 'public', 
		       'command' => proc{visibility.value = 'public' })
public_button.pack('side' => 'left', 'fill' => 'both')

unlisted_button = TkButton.new(tootFrame, 'text' => 'unlisted', 
		       'command' => proc{visibility.value = 'unlisted' })
unlisted_button.pack('side' => 'left', 'fill' => 'both')

private_button = TkButton.new(tootFrame, 'text' => 'private', 
		       'command' => proc{visibility.value = 'private' })
private_button.pack('side' => 'left', 'fill' => 'both')

direct_button = TkButton.new(tootFrame, 'text' => 'direct', 
		       'command' => proc{visibility.value = 'direct' })
direct_button.pack('side' => 'left', 'fill' => 'both')

nsfw_button = TkButton.new(tootFrame, 'text' => 'nsfw', 
		       'command' => proc{sensitive.value == 'true' ? sensitive.value = 'false' : sensitive.value = 'true' })
nsfw_button.pack('side' => 'left', 'fill' => 'both')

cw_button = TkButton.new(tootFrame, 'text' => 'cw', 
			   'command' => proc{spoiler_text.value == "" ? spoiler_text.value = "Contents Warning!" : spoiler_text.value = "";
			   					sensitive.value == 'true' ? sensitive.value = 'false' : sensitive.value = 'true' })
cw_button.pack('side' => 'left', 'fill' => 'both')

quitbutton = TkButton.new(tootFrame, 'text' => 'quit',
		  'command' => proc{exit})
quitbutton.pack('side' => 'right', 'fill' => 'both')

loop do
	Parallel.each([[1, home_timeline, home_timeline.list], [2, local_timeline, local_timeline.list], [3, public_timeline, public_timeline.list]], in_threads: 3) do |call|
		streaming.Timeline(call)
	end
end
end