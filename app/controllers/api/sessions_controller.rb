module Api
  class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
      if user.present? && user.authenticate(params[:password])
        set_user_cookie(user)
        head :ok
      else
        json_response({ error: user.errors })
      end
    end

    def destroy
      invalidate_user_cookie

      head :ok
    end
  end
end