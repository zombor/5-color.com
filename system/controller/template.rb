module Picombo
	module Controllers
		class Template
			@template = 'template'
			def call()
				@template = Picombo::View.new(@template)
			end
		end
	end
end