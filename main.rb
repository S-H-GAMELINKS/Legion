require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'
require 'highline/import'
require 'dotenv'
require 'tk'
require_relative 'input'
require_relative 'mastodon'

Dotenv.load

client = Mastodon::REST::Client.new(base_url: ENV["MASTODON_URL"], bearer_token: ENV["MASTODON_TOKEN"])
mastodon = MastodonAPI.new(client)

var = TkVariable.new('')
entry = TkEntry.new(nil, 'textvariable' => var)
entry.pack('side' => 'top', 'fill' => 'both')
button = TkButton.new(nil, 'text' => 'toot', 
		       'command' => proc{mastodon.Toot(var.value);var.value=""})
button.pack('side' => 'left', 'fill' => 'both')

quitbutton = TkButton.new(nil, 'text' => 'quit',
		  'command' => proc{exit})
quitbutton.pack('side' => 'right', 'fill' => 'both')

Tk.mainloop