class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 
 #takes the auth hash from omniauth to create an user 
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user    
  end
end