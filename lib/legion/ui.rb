
class Timeline
	attr_accessor :list

	def initialize(window, timeline_name)
		@timeline				= TkFrame.new(window)
		@label					= TkLabel.new(@timeline, 'text' => timeline_name, 'width' => 50)
		@list					= TkListbox.new(@timeline, 'height' => 25, 'selectmode' => 'browse')
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
		@options = Hash[:visibility => "public", :sensitive => 'false', :spoiler_text => '']
		@visibility = ['public', 'unlisted', 'private', 'direct']
		@text = text = TkText.new(@tootFrame, 'width' => '50', 'height'=> '30')
		@button = TkButton.new(@tootFrame, 'text' => 'toot', 'command' => proc{mastodon.Toot(@text.value, @options);@text.value=""})
		@mediabutton = TkButton.new(@tootFrame, 'text' => 'media', 'command' => proc{mastodon.MediaUpload(Tk.getOpenFile)})
		@nsfw_button = TkButton.new(@tootFrame, 'text' => 'nsfw', 'command' => proc{@options[:sensitive] == 'true' ? @options[:sensitive] = 'false' : @options[:sensitive] = 'true' })
		@cw_button = TkButton.new(@tootFrame, 'text' => 'cw', 'command' => proc{@options[:spoiler_text] == "" ? @options[:spoiler_text] = "Contents Warning!" : @options[:spoiler_text] = ""; @options[:sensitive] == 'true' ? @options[:sensitive] = 'false' : @options[:sensitive] = 'true' })
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

	def AccountMenu(window, streaming)

		Dotenv.load

		menu = TkMenu.new(window)
		url = ENV["MASTODON_URL"].split(",")
		procArray = Array.new

		url.each do |address|
			menu.add('command', 'label' => "#{address}", 'command' => proc{streaming.num = url.index(address);}, 'underline' => 0)
		end

		return menu
	end

	def VisibilityMenu(window)

		menu = TkMenu.new(window)

		@visibility.each do |visibility|
			menu.add('command', 'label' => "#{visibility}", 'command' => proc{@options[:visibility] = visibility;})
		end

		return menu
	end

	def MenuBar_pack(window, streaming)
		menubar = TkMenu.new(window)

		menubar.add('cascade', 'menu' => self.AccountMenu(window, streaming), 'label' => 'Accounts')
		menubar.add('cascade', 'menu' => self.VisibilityMenu(window), 'label' => 'Visibility')

		window.menu(menubar)
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

	def set(window, streaming)
		self.TootFrame_pack
		self.Text_pack
		self.Button_pack
		self.MediaButton_pack
		self.MenuBar_pack(window, streaming)
		self.NsfwButton_pack
		self.CwButton_pack
		self.Quitbutton_pack
	end
end