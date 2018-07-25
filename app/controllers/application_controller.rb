class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


    protected
	    def after_sign_in_path_for(resource)
	  		# if current_user.present? && current_user.utype == "provider"
	  			"/home"
	  		# end
	  	end
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :organization, :utype, :email, :password])
        end
end
