# Picombo Benchmark Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Bench_Core
		include Singleton

		# Internal hash of benchmarks
		@@marks = {}

		# Starts a benchmark defined by name
		def start(name)
			@@marks[name] = {'start' => Time.new,
			                'stop'  => nil}
		end

		# Stops a benchmark defined by name
		def stop(name)
			# only stop if the benchmark exists
			if (@@marks.has_key?(name))
				@@marks[name]['stop'] = Time.new
			end
		end

		# Gets a benchmark result defined by name
		def get(name, precision = 4)
			if ( ! @@marks.has_key?(name))
				return nil
			else
				start = @@marks[name]['start'].to_f
				stop = @@marks[name]['stop'].to_f
				rounded_number = (Float((stop-start)) * (10 ** precision)).round.to_f / 10 ** precision
				return rounded_number.to_s
			end
		end
	end
end