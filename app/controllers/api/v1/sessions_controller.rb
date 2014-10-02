module Api
  module V1
    class SessionsController < Devise::SessionsController
      # Concerns for token_authenticable
      include TokenAuthentication

      skip_before_action :authenticate_user_from_token!, only: [:create]
      before_action :authenticate_user!, except: [:create]

      def new
        resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        return render status: :ok, json: resource, serializer: UserSerializer
      end

      def create
        resource = warden.authenticate!(auth_options)
        return failure unless resource
        if resource.valid_password?(params[:user][:password])
          resource.ensure_authentication_token
          sign_in resource_name, resource
          return render status: :ok, json: resource, serializer: UserSerializer
        end
        failure
      end

      def destroy
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        render status: :ok, json: {success: true}
      end

      def failure
        return render status: :forbidden, json: {success: false, error: resource.errors}
      end

      protected

      def sign_in_params
        params.require(resource_name.to_sym).permit(:email, :password, :remember_me, :auth_token)
      end

      def auth_options
        {:scope => resource_name, :recall => "#{controller_path}#failure"}
      end

    end
  end
end
