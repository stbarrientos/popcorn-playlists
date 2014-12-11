class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def twitter
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication
			set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
		else
			puts "\n\n\n\n\n\n #{@user.errors.inspect} \n\n\n\n\n\n\n"
			session["devise.twitter_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end
end