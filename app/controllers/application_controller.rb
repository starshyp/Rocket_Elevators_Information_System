class ApplicationController < ActionController::Base
	def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:signup, keys: [:name, :phone])
        devise_parameter_sanitizer.permit(:account_updates, keys: [:name, :phone])
    end
end
