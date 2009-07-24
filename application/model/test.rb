module Picombo
	module Models
		class Test < Picombo::Model
			property :id,	Serial, :key => true
			property :name,	String
			storage_names[:default] = 'test'
		end
	end
end