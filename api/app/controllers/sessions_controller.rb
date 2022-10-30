class SessionsController < ApplicationController
  before_action :validate_user!, only: %i[destroy]
  before_action :verify_user, only: %i[create]

  # For security reasons, not telling the end user explicitly whether the email exists or not
  INVALID_LOGIN_CREDENTIALS = "Email Password combination is incorrect"

  def create
    set_user_cookie!(@user)

    json_response(::UserSerializer.new(@user))
  end

  def destroy
    invalidate_user_cookie!

    head :ok
  end

  private

  def verify_user
    @user = User.find_by_username(params[:username])

    if @user.blank? || !@user.authenticate(params[:password])
      handle_error(INVALID_LOGIN_CREDENTIALS, :not_found)
    end
  end
end
