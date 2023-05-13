class DeviseFailureApp < Devise::FailureApp
  def respond
    if http_auth?
      redirect_to new_user_session_path
    elsif warden_options[:recall]
      recall
    else
      redirect
    end
  end
end
