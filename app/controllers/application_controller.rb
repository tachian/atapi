class ApplicationController < ActionController::Metal
  # Enables rendering (JSON)
  include ActionController::Rendering
  include ActionController::Renderers::All
  # Enables request forgery protection
  include ActionController::RequestForgeryProtection
  # Support Rails 4 Strong Parameters
  include ActionController::StrongParameters
  # Enables serving different content types like :xml or :json
  include ActionController::MimeResponds
  # Callbacks for controllers (before_action, etc.)
  include AbstractController::Callbacks
  # Serialization support
  include ActionController::Serialization
  # Cookies support
  include ActionController::Cookies
  # Route helpers
  include Rails.application.routes.url_helpers
  # Respond with a simple HTTP header
  include ActionController::Head
  # Doorkeeper Filters
  include Doorkeeper::Helpers::Filter
  # Devise Helpers
  include ActionController::HideActions
  include Devise::Controllers::Helpers
  # File streaming
  include ActionController::DataStreaming
  # Enable rescue_from errors
  include ActionController::Rescue


  # Custom error handling
  rescue_from StandardError, with: :error_handler

  # Route error endpoint
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  # Forbidden access endpoint (403)
  def forbidden
    head :forbidden
  end

  protected

    def error_handler(error)
      error_class = error.class.name.parameterize.underscore.to_sym
      status = :application_error
      response = {errors: [{error_class => [error.message]}]}
      # Invalid or not found route
      if error.class.name == "ActionController::RoutingError"
        status = :not_found
      end
      # Strong parameters missing parameter
      if error.class.name == "ActionController::ParameterMissing"
        status = :bad_request
      end
      # Invalid or not found record
      if error.class.name == "ActiveRecord::RecordNotFound"
        status = :not_found
      end
      # Invalid role
      if error.class.name == "CanCan::AccessDenied"
        status = :forbidden
      end

      render status: status, json: response
    end

end

