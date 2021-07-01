
module RailsAdmin
  module Config
    module Actions
      class Maps < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :breadcrumb_parent do
          nil
        end

        register_instance_option :link_icon do
			'maps.html.erb'
        end

        register_instance_option :link_icon do
			'icon-image'
		end
      end
    end
  end
end