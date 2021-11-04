module Api
  class TestController < ApplicationController
    before_action :validate_user

    def index
      render json: {
        data: [
          "1",
          "2",
          "3",
        ]
      }
    end
  end
end
