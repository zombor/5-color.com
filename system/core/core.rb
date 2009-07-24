# Picombo Core Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Core

		# Standard call function that gets invoked by Rack
		def call(env)
			# start system benchmark
			Picombo::Bench.instance.start('application')
			Picombo::Bench.instance.start('loading')

			# Add directory extensions to the filesystem
			Picombo::Config.get('config.extensions').each do |extension|
				if ! $LOAD_PATH.include?(EXTPATH+extension)
					$LOAD_PATH.unshift(EXTPATH+extension)
				end
			end

			# Set up database
			DataMapper.setup(:default,
			                 {:host => Picombo::Config.get('database.default.host'),
			                  :adapter => Picombo::Config.get('database.default.driver'),
			                  :database => Picombo::Config.get('database.default.database'),
			                  :username => Picombo::Config.get('database.default.username'),
			                  :password => Picombo::Config.get('database.default.password')})

			@@response = Rack::Response.new
			@@response['Content-Type'] = 'text/html'
			@@response.status = 200
			@@redirect = []
			@@env = env
			@@req = Rack::Request.new(env)

			## intialize the input library
			Picombo::Input.instance.set_request(@@req)
			Picombo::Session.instance.init(@@req)
			Picombo::Cookie.instance.init(@@req)
			Picombo::Bench.instance.stop('loading')

			Picombo::Log.write('info', 'Picombo Setup Complete')
			Picombo::Router.new(@@req).process()
		end

		# Sets a system redirect
		def self.redirect(location, status = 302)
			@@redirect = [Picombo::Url.base+location, status]
		end

		# Adds content to the output buffer
		def self.response(str, status = 200)
			@@response.status = status
			@@response.write(str)
		end

		# Allows access to raw response object
		def self.raw_response
			@@response
		end

		# Renders the output buffer. Called by Picombo::Heart::Router only.
		def self.render
			if ! @@redirect.empty?
				@@response.redirect(*@@redirect)
			end

			response = @@response.finish
			@@response = nil
			response
		end

		# Finds a file recursively in the CFS.
		# Searches application, then module locations, then system.
		# If directory is a config dir, it returns an array of all locations
		def self.find_file(directory, file, required = false, ext = false)
			if ext == false
				ext = ".rb"
			else
				ext = "."+ext
			end

			if directory == "config"
				configs = []
				$LOAD_PATH.each do |path|
					if File.exist?(path+directory+"/"+file+ext)
						configs.unshift(path+directory+"/"+file+ext)
					end
				end
				return configs
			else
				$LOAD_PATH.each do |path|
					if File.exist?(path+directory+"/"+file+ext)
						return path+directory+"/"+file+ext
					end
				end
			end

			raise "File Not Found!!" if required

			false
		end
	end

	def Picombo.const_missing(name)
		str_name = name.to_s

		# the filenames do not have _Core on them, so remove it for the base loading
		core = str_name.index('_Core')
		filename = str_name.gsub(/_Core$/, '')

		# Load the base file
		require 'classes/'+filename.downcase

		# Load a custom extension if there is one
		if (filename = Picombo::Core.find_file('helper', Picombo::Config_Core.get('config.extension_prefix')+filename))
			require filename
		elsif (const_defined?(str_name+'_Core'))
			eval('class '+str_name+' < '+str_name+"_Core\nend")
		end

		klass = const_get(name)
		return klass if klass
	end

	module Models
		def Models.const_missing(name)
			# look in the core folder for autoloading the file
			str_name = name.to_s
			require 'model/'+str_name.downcase
			klass = const_get(name)
			return klass if klass
		end
	end

	module Controllers
		def Controllers.const_missing(name)
			# look in the core folder for autoloading the file
			str_name = name.to_s
			require 'controller/'+str_name.downcase
			klass = const_get(name)
			return klass if klass
		end
	end
end