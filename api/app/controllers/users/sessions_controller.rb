class Users::SessionsController < Devise::SessionsController
  include HasRackSession

  respond_to :json

  def destroy
    @authenticated = true
    super
  end

  private

  def verify_signed_out_user
    current_user
    super
  end

  def login_failed
    render json: {
      message: "User couldn't be logged in successfully.",
      errors: ["Invalid Email or Password."]
    }, status: :unprocessable_entity
  end

  def login_successful
    render json: {
      message: "Logged in sucessfully.",
      user: current_user.as_json(except: :jti)
    }, status: :ok
  end

  def logout_failed
    render json: {
      message: "Hmm nothing happened."
    }, status: :unprocessable_entity
  end

  def logout_successful
    render json: {
      message: "logged out successfully"
    }, status: :ok
  end

  def respond_to_on_destroy
    return logout_successful if @authenticated && current_user.nil?

    logout_failed
  end

  def respond_with(_resource, _opts = {})
    return login_successful if current_user

    login_failed
  end
end
