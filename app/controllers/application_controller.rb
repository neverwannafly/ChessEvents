class ApplicationController < ActionController::Base
  attr_accessor :current_user

  def validate_user
    token = cookies[:authorization]
    head :bad_request and return unless token.present?

    token = Lib::JwtAuth.validate_token(token)
    head :forbidden and return unless token.present?

    @current_user ||= User.find(token[:id])
  end

  def set_user_cookie(user)
    token = Lib::JwtAuth.issue_token(user)
    cookies[:authorization] = { value: token, httponly: true }
  end
end
