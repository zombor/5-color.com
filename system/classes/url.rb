# Picombo URL Helper
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Url_Core
		# Returns the base URL for use with any internal links.
		def self.base
			Picombo::Config.get('config.protocol')+"://"+Picombo::Config.get('config.site_domain')+'/'
		end
	end
end