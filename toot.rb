require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'mastodon'

window = TkToplevel.new do   #タイトルバーの表示
    title( "Legion" )
end

Dotenv.load

tootFrame = TkFrame.new(window)
tootFrame.pack('side' => 'left', 'fill' => 'both')

home_timeline = TkFrame.new(window)
home_timeline.pack('side' => 'left', 'fill' => 'both')

htl_label = TkLabel.new(home_timeline, 'text' => 'ホームタイムライン')
htl_label.pack('side' => 'top', 'fill' => 'both')

htl_list = TkListbox.new(home_timeline, 'height' => 25, 'selectmode' => 'multiple')
htl_list.pack('fill' => 'both')

local_timeline = TkFrame.new(window)
local_timeline.pack('side' => 'left', 'fill' => 'both')

ltl_label = TkLabel.new(local_timeline, 'text' => 'ローカルタイムライン')
ltl_label.pack('side' => 'top', 'fill' => 'both')

ltl_list = TkListbox.new(local_timeline, 'height' => 25, 'selectmode' => 'multiple')
ltl_list.pack('fill' => 'both')

public_timeline = TkFrame.new(window)
public_timeline.pack('side' => 'left', 'fill' => 'both')

ftl_label = TkLabel.new(public_timeline, 'text' => '連合タイムライン')
ftl_label.pack('side' => 'top', 'fill' => 'both')

ftl_list = TkListbox.new(public_timeline, 'height' => 25, 'selectmode' => 'multiple')
ftl_list.pack('fill' => 'both')

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
mastodon = MastodonAPI.new(client)

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
streaming = MastodonStreaming.new(stream)

var = TkVariable.new('')

text = TkText.new(tootFrame, 'width' => '30', 'height'=> '30')
text.pack('side' => 'top', 'fill' => 'both')

button = TkButton.new(tootFrame, 'text' => 'toot', 
		       'command' => proc{mastodon.Toot(text.value);text.value=""})
button.pack('side' => 'left', 'fill' => 'both')

mediabutton = TkButton.new(tootFrame, 'text' => 'media', 
		       'command' => proc{mastodon.MediaUpload(Tk.getOpenFile)})
mediabutton.pack('side' => 'left', 'fill' => 'both')

quitbutton = TkButton.new(tootFrame, 'text' => 'quit',
		  'command' => proc{exit})
quitbutton.pack('side' => 'right', 'fill' => 'both')

loop do
	Parallel.each([htl_list.insert('end', streaming.HomeTimeline(home_timeline)), ltl_list.insert('end', streaming.LocalTimeline(local_timeline)), ftl_list.insert('end', streaming.PublicTimeline(public_timeline))]) do |l|
		l
	end
end