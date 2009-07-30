# Picombo HTML Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Html_Core
		include Singleton

		def self.email(email)
			safe = []

			email.each_byte do |char|
				safe << '&#'+char.to_s
			end

			safe.join
		end
	end
end