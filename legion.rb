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

htl_label = TkLabel.new(home_timeline, 'text' => 'ホームタイムライン', 'width' => 50)
htl_label.pack('side' => 'top', 'fill' => 'both')

htl_list = TkListbox.new(home_timeline, 'height' => 25, 'selectmode' => 'multiple')
htl_list.pack('fill' => 'both')

home_timeline_yscrollbar = TkScrollbar.new(htl_list) {orient "vertical"; command proc{|*args| htl_list.yview(*args);} }
htl_list['yscrollcommand'] = proc{|*args| home_timeline_yscrollbar.set(*args);}
home_timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')

home_timeline_xscrollbar = TkScrollbar.new(htl_list) {orient "horizontal"; command proc{|*args| htl_list.xview(*args);} }
htl_list['xscrollcommand'] = proc{|*args| home_timeline_xscrollbar.set(*args);}
home_timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')

local_timeline = TkFrame.new(window)
local_timeline.pack('side' => 'left', 'fill' => 'both')

ltl_label = TkLabel.new(local_timeline, 'text' => 'ローカルタイムライン', 'width' => 50)
ltl_label.pack('side' => 'top', 'fill' => 'both')

ltl_list = TkListbox.new(local_timeline, 'height' => 25, 'selectmode' => 'multiple')
ltl_list.pack('fill' => 'both')

local_timeline_yscrollbar = TkScrollbar.new(ltl_list) {orient "vertical"; command proc{|*args| ltl_list.yview(*args);} }
ltl_list['yscrollcommand'] = proc{|*args| local_timeline_yscrollbar.set(*args);}
local_timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')

local_timeline_xscrollbar = TkScrollbar.new(ltl_list) {orient "horizontal"; command proc{|*args| ltl_list.xview(*args);} }
ltl_list['xscrollcommand'] = proc{|*args| local_timeline_xscrollbar.set(*args);}
local_timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')

public_timeline = TkFrame.new(window)
public_timeline.pack('side' => 'left', 'fill' => 'both')

ftl_label = TkLabel.new(public_timeline, 'text' => '連合タイムライン', 'width' => 50)
ftl_label.pack('side' => 'top', 'fill' => 'both')

ftl_list = TkListbox.new(public_timeline, 'height' => 25, 'selectmode' => 'multiple')
ftl_list.pack('fill' => 'both')

public_timeline_yscrollbar = TkScrollbar.new(ftl_list) {orient "vertical"; command proc{|*args| ftl_list.yview(*args);} }
ftl_list['yscrollcommand'] = proc{|*args| public_timeline_yscrollbar.set(*args);}
public_timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')

public_timeline_xscrollbar = TkScrollbar.new(ftl_list) {orient "horizontal"; command proc{|*args| ftl_list.xview(*args);} }
ftl_list['xscrollcommand'] = proc{|*args| public_timeline_xscrollbar.set(*args);}
public_timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
mastodon = MastodonAPI.new(client)

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
streaming = MastodonStreaming.new(stream)

visibility = TkVariable.new('public')

text = TkText.new(tootFrame, 'width' => '50', 'height'=> '30')
text.pack('side' => 'top', 'fill' => 'both')

button = TkButton.new(tootFrame, 'text' => 'toot', 
		       'command' => proc{mastodon.Toot(text.value, visibility.value);text.value=""})
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

quitbutton = TkButton.new(tootFrame, 'text' => 'quit',
		  'command' => proc{exit})
quitbutton.pack('side' => 'right', 'fill' => 'both')

loop do
	Parallel.each([htl_list.insert('0', streaming.HomeTimeline(home_timeline)), ltl_list.insert('0', streaming.LocalTimeline(local_timeline)), ftl_list.insert('0', streaming.PublicTimeline(public_timeline))]) do |l|
		l
	end
end