require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'input'
require_relative 'mastodon'

TkRoot.new do   #タイトルバーの表示
    title( "ファイル選択ボタン" )
end

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
mastodon = MastodonAPI.new(client)

stream = Mastodon::Streaming::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])

var = TkVariable.new('')

text = TkText.new(nil, 'width' => '30', 'height'=> '30')
text.pack('side' => 'top', 'fill' => 'both')

button = TkButton.new(nil, 'text' => 'toot', 
		       'command' => proc{mastodon.Toot(text.value);text.value=""})
button.pack('side' => 'left', 'fill' => 'both')

mediabutton = TkButton.new(nil, 'text' => 'media', 
		       'command' => proc{mastodon.MediaUpload(Tk.getOpenFile)})
mediabutton.pack('side' => 'left', 'fill' => 'both')

htl_button = TkButton.new(nil, 'text' => 'HTL',
          'command' => proc{htl_window = TkToplevel.new;htl_window.title('ホームタイムライン');
                            stream.user() do |toot|
                            puts toot.content
                            end})
htl_button.pack('side' => 'left', 'fill' => 'both')

ltl_button = TkButton.new(nil, 'text' => 'LTL',
		  'command' => proc{ltl_window = TkToplevel.new;newwindow.title('ローカルタイムライン')})
ltl_button.pack('side' => 'left', 'fill' => 'both')

ftl_button = TkButton.new(nil, 'text' => 'FTL',
		  'command' => proc{ftl_window = TkToplevel.new;newwindow.title('連合タイムライン')})
ftl_button.pack('side' => 'left', 'fill' => 'both')

quitbutton = TkButton.new(nil, 'text' => 'quit',
		  'command' => proc{exit})
quitbutton.pack('side' => 'right', 'fill' => 'both')

Tk.mainloop