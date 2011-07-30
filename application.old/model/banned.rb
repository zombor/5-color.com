module Picombo
	module Models
		class Banned < Picombo::Model
			property :id,		Serial
			property :name,		String
			property :status,	String
			storage_names[:default] = 'banned'
		end
	end
end