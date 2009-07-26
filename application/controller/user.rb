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
				post = Picombo::Input.instance.post
				card = Picombo::Models::Banned.new(:name => post['name'], :status => post['status'])
				card.save

				Picombo::Core.redirect('admin/remove_banned')
			end
			
			def temp
				user = Picombo::Models::User.first(:username => 'zombor')
				user.password = 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3'
				user.save
				
				Picombo::Core.redirect('user/login')
			end
		end
	end
end