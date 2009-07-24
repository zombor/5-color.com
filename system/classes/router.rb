# Picombo Router Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

# Processes the URI to route requests to proper controller

module Picombo
	class Router_Core
		@@req = nil

		def initialize(req)
			@@req = req
		end

		# Processes the URI
		def process()
			Picombo::Bench.instance.start('setup')

			# Find the controller and method
			uri = Picombo::Router.process_uri(@@req.path())

			#@controller, @method = router_parts[1], router_parts[2]

			#params = router_parts.slice(3, router_parts.length)

			# Try and load the controller class
			begin
				controller = Picombo::Controllers::const_get(uri[:controller].capitalize!).new
			rescue LoadError
				return [404, {'Content-Type' => 'text/html'}, '404 NOT FOUND!']
			end

			controller_methods = controller.methods

			Picombo::Bench.instance.stop('setup')

			# Execute the controller method
			Picombo::Bench.instance.start('controller_execution')
			if controller_methods.include?(uri[:method])
				if uri[:params].nil? or uri[:params].empty?
					controller.send(uri[:method])
				else
					controller.send(uri[:method], *uri[:params])
				end
			else
				return [404, {'Content-Type' => 'text/html'}, '404 NOT FOUND!']
			end

			Picombo::Bench.instance.stop('controller_execution')
			Picombo::Bench.instance.stop('application')

			Picombo::Core.render
		end

		def self.process_uri(path)
			router_parts = path == '/' ? ('/'+Picombo::Config.get('routes.default')).split('/') : path.split('/')

			# Strip out any GET parts
			params = router_parts.slice(3, router_parts.length)

			if ! params.nil?
				params.collect! do |param|
					param.split('?').at(0)
				end
			else
				params = []
			end

			if ! router_parts[2].nil?
				router_parts[2] = router_parts[2].split('?').at(0)
			else
				router_parts[2] = ('/'+Picombo::Config.get('routes.default')).split('/').at(2)
			end

			# make sure to remove the GET from any of the parameters
			{:controller => router_parts[1].split('?').at(0), :method => router_parts[2], :params => params}
		end
	end
end