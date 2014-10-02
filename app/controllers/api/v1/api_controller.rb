module Api
  module V1
    class ApiController < ApplicationController
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      # if Rails.env.production?
      #   protect_from_forgery with: :null_session
      # end

      # Prevent CSRF attacks by checking headers from AngularJS
      before_action :verified_request?

      # Only listen and responds to JSON requests
      before_action :ensure_json_request

      # Passing rails CSRF protection to AngularJS
      after_action :set_csrf_cookie_for_ng

      def set_csrf_cookie_for_ng
        cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
      end

      # Check to see if the oncoming request is on JSON format
      def ensure_json_request
        return if params[:format] == 'json' || request.headers['Accept'] =~ /json/
        head :not_acceptable
      end

      # Get API data from request header
      def api_data
        accept = request.headers['Accept']
     
        if accept
          mime_type, version = accept.gsub(/\s/, "").split(";")
          mime_type, format = mime_type.split("+")
          version = version.split("=").pop.to_i unless version.nil?
        end

        {mime_type: mime_type, format: format, version: version}
      end

      # Forbidden access endpoint (403)
      def forbidden
        head :forbidden
      end

      protected

        def verified_request?
          super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
        end

    end
  end
end