module TokenAuthenticationHelper
  def sign_in(user)
    token = ::JwtAuth.issue_token(user)
    session[:authorization] = token
  end

  def current_user
    token = session[:authorization]
    return unless token.present?

    token = ::JwtAuth.validate_token(token)
    return unless token.present?

    @current_user ||= User.find_by(id: token[:id])
  end
end
