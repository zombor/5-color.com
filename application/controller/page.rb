module Picombo
	module Controllers
		class Page < Picombo::Controllers::Template
			def index()
				template = Picombo::View.new('template')
				body = Picombo::View.new('page/index')

				template.set('body', body.render(true))
				template.render
			end

			def banned()
				template = Picombo::View.new('template')
				body = Picombo::View.new('page/banned')

				body.set('banned', Picombo::Models::Banned)

				template.set('body', body.render(true))
				template.render
			end
		end
	end
end