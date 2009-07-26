module Picombo
	module Models
		class User < Picombo::Model
			property :id,		Serial
			property :username,	String
			property :password,	String
			storage_names[:default] = 'users'
		end
	end
end