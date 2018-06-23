
class Timeline
    attr_accessor :list

	def initialize(window, timeline_name)
		@timeline				= TkFrame.new(window)
		@label					= TkLabel.new(@timeline, 'text' => timeline_name, 'width' => 50)
		@list					= TkListbox.new(@timeline, 'height' => 25, 'selectmode' => 'multiple')
		@timeline_xscrollbar	= TkScrollbar.new(@list) {orient "vertical"; command proc{|*args| @list.yview(*args);} }
		@timeline_yscrollbar	= TkScrollbar.new(@list) {orient "horizontal"; command proc{|*args| @list.xview(*args);} }
	end

	def timeline_pack
		return @timeline.pack('side' => 'left', 'fill' => 'both')
	end

	def label_pack
		return @label.pack('side' => 'top', 'fill' => 'both')
	end

	def list_pack
		return @list.pack('fill' => 'both')
	end

	def y_scrollbar		
		@list['yscrollcommand'] = proc{|*args| @timeline_yscrollbar.set(*args);}
		return @timeline_yscrollbar.pack('side' => 'right', 'fill' => 'both', 'ipadx' => '5', 'ipady' => '170')
	end

	def x_scrollbar
		@list['xscrollcommand'] = proc{|*args| @timeline_xscrollbar.set(*args);}
		return @timeline_xscrollbar.pack('side' => 'bottom', 'fill' => 'both')
    end
    
    def set
        self.timeline_pack
        self.label_pack
        self.list_pack
    end
end