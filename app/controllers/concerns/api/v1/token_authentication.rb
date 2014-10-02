module Api
  module V1
    module TokenAuthentication
      extend ActiveSupport::Concern

      # Please see https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
      # before editing this file, the discussion is very interesting.

      included do
        private :authenticate_user_from_token!
        # This is our new function that comes before Devise's one
        prepend_before_action :authenticate_user_from_token!
        # This is Devise's authentication
        before_action :authenticate_user!
      end

      # For this example, we are simply using token authentication
      # via parameters. However, anyone could use Rails's token
      # authentication features to get the token from a header.
      def authenticate_user_from_token!
        # Set the authentication params if not already present
        if user_token = params[:user_token].blank? && request.headers["X-User-Token"]
          params[:user_token] = user_token
        end
        if user_email = params[:user_email].blank? && request.headers["X-User-Email"]
          params[:user_email] = user_email
        end

        user_email = params[:user_email].presence
        user = user_email && User.where(email: user_email).first

        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        if user && Devise.secure_compare(user.authentication_token, params[:user_token])
          # Notice we are passing store false, so the user is not
          # actually stored in the session and a token is needed
          # for every request. If you want the token to work as a
          # sign in token, you can simply remove store: false.
          sign_in user, store: false
        end
      end

      module ClassMethods
        # nop
      end
    end
  end
end