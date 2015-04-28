class ApiController < ActionController::Base

  before_action :authenticate_user_from_token!

  protected

  def authenticate_user_from_token!
    if params[:user_token]
      user_email = params[:user_email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, params[:user_token])
        sign_in user, store: false
      end
    end
  end

end