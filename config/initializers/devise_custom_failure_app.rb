class DeviseCustomAuthFailure < Devise::FailureApp
  def respond
    self.status = :forbidden
    self.content_type = :json
    message = I18n.t "devise.failure." + warden_message.to_s
    self.response_body = {success: false, errors: {type: warden_message, message: message}}.to_json
  end 
end