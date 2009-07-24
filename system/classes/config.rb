# Picombo Config Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Config_Core
		include Enumerable

		# Internal cache.
		@@cache = {}

		# Loads configuration files by name
		def self.load(name)
			configuration, files = {}, Picombo::Core.find_file('config', name, false, 'yaml')

			files.each do |file|
				configuration.merge! YAML::load_file(file)
			end

			configuration
			rescue Errno::ENOENT => e
			# A config file couldn't be loaded...
		end

		def self.set(key, value)
		end

		# Retrieves a config item in dot notation
		def self.get(key, required = true)
			# get the group name from the key
			key = key.split('.')
			group = key.shift

			value = key_string(load(group), key.join('.'))

			raise "Library::Config key '"+key.join('.')+"' not found!!" if required && value.nil?

			value
		end

		def self.clear(group)

		end

		# Allows searching an hash by dot seperated strings
		def self.key_string(hash, keys)
			return false if ! hash.is_a? Hash

			keys = keys.split('.')

			until keys.length == 0
				key = keys.shift

				if hash.has_key? key
					if hash[key].is_a? Hash and ! keys.empty?
						hash = hash[key]
					else
						return hash[key]
					end
				else
					break
				end
			end

			nil
		end

		#
		# Define an each method, required for Enumerable.
		#
		def self.each(file)

		end
	end
end