class CurrentUserController < ApplicationController
  def show
    render json: {
      message: "Logged in sucessfully.",
      data: current_user.as_json(except: :jti)
    }, status: :ok
  end
end
