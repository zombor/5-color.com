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
					Picombo::Input.instance.post('card').each do |card_id|
						card = Picombo::Models::Banned.get(card_id[0]).destroy
					end
					Picombo::Core.redirect('admin/remove_banned')
				end
			end
		end
	end
end