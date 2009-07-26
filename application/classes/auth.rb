# Picombo Auth Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

require 'digest/sha1'

module Picombo
	class Auth_Core
		include Singleton

		def login(user, password)
			user = Picombo::Models::User.first(:username => user, :password => Digest::SHA1.hexdigest(password))
Picombo::Core.response('Tried '+{:username => user, :password => Digest::SHA1.hexdigest(password)}.inspect)
			if ! user.id.nil?
				# set the session as logged in
				Picombo::Session.instance.set(:loggedin, true)
				Picombo::Session.instance.set(:user, user)

				true
			end
			Picombo::Core.response(user.inspect)
			false
		end

		def logout
			Picombo::Session.instance.unset(:loggedin)
			Picombo::Session.instance.unset(:user)
		end

		def self.loggedin
			Picombo::Session.instance.get(:loggedin).nil?
		end
	end
end