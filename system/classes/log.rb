# Picombo Input Class
#
# Author:: Jeremy Bush
# Copyright:: Copyright (c) 2009 Jeremy Bush
# License:: See LICENSE

module Picombo
	class Log_Core
		include Singleton

		# Writes type log entry with message
		def self.write(type, message)
			types = {'none' => 0, 'info' => 1, 'warning' => 2, 'notice' => 3, 'debugging' => 4}

			if types[type] <= Picombo::Config.get('log.log_threshold')
				t = Time.now
				f = File.new(APPPATH+Picombo::Config.get('log.directory')+t.year.to_s+'-'+t.month.to_s+'-'+t.day.to_s+'.log', 'a')
				f.write(t.to_s+' --- '+type.to_s+': '+message.to_s+"\n");
				f.close
			end
		end
	end
end