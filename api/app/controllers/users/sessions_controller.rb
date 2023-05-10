class Users::SessionsController < Devise::SessionsController
  include HasRackSession

  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    return login_successful if current_user

    login_failed
  end

  def login_successful
    render json: {
      message: "Logged in sucessfully.",
      data: current_user.as_json(except: :jti)
    }, status: :ok
  end

  def login_failed
    render json: {
      message: "Invalid Email or Password."
    }, status: :unprocessable_entity
  end

  def respond_to_on_destroy
    return logout_successful if current_user

    logout_failed
  end

  def logout_successful
    render json: {
      message: "logged out successfully"
    }, status: :ok
  end

  def logout_failed
    render json: {
      message: "Hmm nothing happened."
    }, status: :not_found
  end
end
