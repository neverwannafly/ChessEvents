class ApplicationController < ActionController::Base
  attr_accessor :current_user

  def validate_user
    token = cookies[:authorization]
    if !token
      head :forbidden and return
    end

    token = Lib::JwtAuth.validate_token(token)

    unless token
      head :forbidden and return
    end

    @current_user ||= User.find(token[:id])
  end

  def set_user_cookie(user)
    token = Lib::JwtAuth.issue_token(user)
    cookies[:authorization] = { value: token, httponly: true }
  end
end
