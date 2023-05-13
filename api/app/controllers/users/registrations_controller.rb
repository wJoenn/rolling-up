class Users::RegistrationsController < Devise::RegistrationsController
  include HasRackSession

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    return deletion_successful if request.method == "DELETE"

    if request.method == "POST" && resource.persisted?
      registration_successful
    else
      registration_failed
    end
  end

  def deletion_successful
    render json: {
      message: "Account deleted successfully."
    }, status: :ok
  end

  def registration_failed
    render json: {
      message: "User couldn't be created successfully.",
      errors: resource.errors.full_messages
    }, status: :unprocessable_entity
  end

  def registration_successful
    render json: {
      message: "Signed up successfully.",
      user: current_user.as_json(except: :jti)
    }, status: :ok
  end
end
