# Picombo Input Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Input_Core
		include Singleton

		# Sets the input request
		def set_request(req)
			@req = req
			Picombo::Log.write('info', 'Input Library initialized')
		end

		# Retrieves a GET item by key. If the key doesn't exist, return default
		def get(key = nil, default = nil)
			return @req.GET() if key.nil?

			get = @req.GET()
			return get[key] if get.has_key?(key)

			return default
		end

		# Retrieves a POST item by key. If the key doesn't exist, return default
		def post(key = nil, default = nil)
			return @req.POST() if key.nil?

			post = @req.POST()
			return post[key] if post.has_key?(key)

			return default
		end
	end
end