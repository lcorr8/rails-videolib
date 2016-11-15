class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  #after_action :verify_authorized #ensure yu havent forgotten to authrize any actions
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    #devise helper.
     sections_path
  end

  def study_suggestions
    @videos = Video.all
  end

  def home
    skip_authorization
  end

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || sections_path || root_path)
  end
  
end
