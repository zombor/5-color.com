module Picombo
	module Controllers
		class Admin < Picombo::Controllers::Template
			def remove_banned()
				if Picombo::Input.instance.post.empty?
					template = Picombo::View.new('template')
					body = Picombo::View.new('admin/remove_banned')

					body.set('banned', Picombo::Models::Banned.all)

					template.set('body', body.render(true))
					template.render
				else
					Picombo::Core.response(Picombo::Input.instance.post.inspect)
				end
			end
		end
	end
end