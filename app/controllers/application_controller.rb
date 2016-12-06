class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  #after_action :verify_authorized #ensure you havent forgotten to authrize any actions
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  #devise helper
  def after_sign_in_path_for(resource)
     sections_path
  end

  def study_suggestions
    @videos = Video.all
  end

  def home
    #does devise give you a logged_in? helper? = user_igned_in? and current_user
    if user_signed_in?
      redirect_to sections_path
    end
      #skip_authorization
  end

  private
  #helper written to rescue pundit policy errors with this message
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || sections_path || root_path)
  end
  
end
