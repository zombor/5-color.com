module Picombo
	module Controllers
		class User < Picombo::Controllers::Template
			def login
				template = Picombo::View.new('template')
				body = Picombo::View.new('user/login')
				body.set('error', '')

				if ! Picombo::Input.instance.post.empty?
					if Picombo::Auth.instance.login(Picombo::Input.instance.post('username'), Picombo::Input.instance.post('password'))
						Picombo::Core.redirect('admin/remove_banned')
					else
						body.set('error', 'Invalid password or unknown username')
					end
				end

				template.set('body', body.render(true))
				template.render
			end

			def logout
				Picombo::Auth.instance.logout

				Picombo::Core.redirect('admin/remove_banned')
			end
		end
	end
end