require 'bundler/setup'
Bundler.require(:default)

require 'mastodon'

Window.loop do


    #エスケープキーでループを抜ける
	if Input.key_push?(K_ESCAPE) then
		break
	end
end