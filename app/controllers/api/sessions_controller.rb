module Api
  class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
      head :not_found and return if user.blank?

      if user.present? && user.authenticate(params[:password])
        set_user_cookie(user)
        json_response({
          username: user.username,
          name: user.name || '',
        })
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
