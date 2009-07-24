module Picombo
	class View_Core
		@view_file = ''
		@view_data = []

		def initialize(filename)
			@view_data = {}
			view_location = Picombo::Core.find_file('views', filename, false, 'rhtml')

			if view_location.nil?
				raise IOError
			end

			@view_file = view_location
		end

		# Support templating of member data.
		def get_binding
			binding
		end

		def set(key, val)
			instance_variable_set "@#{key}", val
		end

		def render(echo = false)
			view = ERB::new(File.read(@view_file))

			if echo
				view.result(get_binding())
			else
				Picombo::Core.response view.result(get_binding())
			end
		end
	end
end