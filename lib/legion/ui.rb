
class Timeline
	attr_accessor :list

	def initialize(window, timeline_name)
		@timeline				= TkFrame.new(window)
		@label					= TkLabel.new(@timeline, 'text' => timeline_name, 'width' => 50)
		@list					= TkListbox.new(@timeline, 'height' => 25, 'selectmode' => 'multiple')
	end

	def timeline_pack
		@timeline.pack('side' => 'left', 'fill' => 'both')
	end

	def label_pack
		@label.pack('side' => 'top', 'fill' => 'both')
	end

	def list_pack
		@list.pack('fill' => 'both')
	end
    
    def set
        self.timeline_pack
        self.label_pack
		self.list_pack
    end
end

class TootFrame

	def initialize(window, mastodon)
		@tootFrame = TkFrame.new(window)
		@visibility = TkVariable.new('public')
		@sensitive = TkVariable.new('false')
		@spoiler_text = TkVariable.new("")
		@text = text = TkText.new(@tootFrame, 'width' => '50', 'height'=> '30')
		@button = TkButton.new(@tootFrame, 'text' => 'toot', 'command' => proc{mastodon.Toot(@text.value, @visibility.value, @sensitive.value, @spoiler_text.value);@text.value=""})
		@mediabutton = TkButton.new(@tootFrame, 'text' => 'media', 'command' => proc{mastodon.MediaUpload(Tk.getOpenFile)})
		@public_button = TkButton.new(@tootFrame, 'text' => 'public', 'command' => proc{@visibility.value = 'public' })
		@unlisted_button = TkButton.new(@tootFrame, 'text' => 'unlisted', 'command' => proc{@visibility.value = 'unlisted' })
		@private_button = TkButton.new(@tootFrame, 'text' => 'private', 'command' => proc{@visibility.value = 'private' })
		@direct_button = TkButton.new(@tootFrame, 'text' => 'direct', 'command' => proc{@visibility.value = 'direct' })
		@nsfw_button = TkButton.new(@tootFrame, 'text' => 'nsfw', 'command' => proc{@sensitive.value == 'true' ? @sensitive.value = 'false' : @sensitive.value = 'true' })
		@cw_button = TkButton.new(@tootFrame, 'text' => 'cw', 'command' => proc{@spoiler_text.value == "" ? @spoiler_text.value = "Contents Warning!" : @spoiler_text.value = ""; @sensitive.value == 'true' ? @sensitive.value = 'false' : @sensitive.value = 'true' })
		@quitbutton = TkButton.new(@tootFrame, 'text' => 'quit', 'command' => proc{exit})
	end

	def TootFrame_pack
		@tootFrame.pack('side' => 'left', 'fill' => 'both')
	end

	def Text_pack
		@text.pack('side' => 'top', 'fill' => 'both')
	end

	def Button_pack
		@button.pack('side' => 'left', 'fill' => 'both')
	end

	def MediaButton_pack
		@mediabutton.pack('side' => 'left', 'fill' => 'both')
	end

	def PubilcButton_pack
		@public_button.pack('side' => 'left', 'fill' => 'both')
	end

	def UnlistedButton_pack
		@unlisted_button.pack('side' => 'left', 'fill' => 'both')
	end

	def PrivateButton_pack
		@private_button.pack('side' => 'left', 'fill' => 'both')
	end

	def DirectButton_pack
		@direct_button.pack('side' => 'left', 'fill' => 'both')
	end

	def NsfwButton_pack
		@nsfw_button.pack('side' => 'left', 'fill' => 'both')
	end

	def CwButton_pack
		@cw_button.pack('side' => 'left', 'fill' => 'both')
	end

	def Quitbutton_pack
		@quitbutton.pack('side' => 'right', 'fill' => 'both')
	end

	def set
		self.TootFrame_pack
		self.Text_pack
		self.Button_pack
		self.PubilcButton_pack
		self.MediaButton_pack
		self.UnlistedButton_pack
		self.PrivateButton_pack
		self.DirectButton_pack
		self.NsfwButton_pack
		self.CwButton_pack
		self.Quitbutton_pack
	end
end