module Api
  module V1
    class PasswordsController < Devise::PasswordsController

      def create
        user = User.send_reset_password_instructions(params[:user])
        if successfully_sent?(user)
          render status: :ok, json: {success: true}
        else
          render status: :unprocessable_entity, json: {errors: user.errors.full_messages}
        end
      end

      def update
        user = resource_class.reset_password_by_token(params[:user])
        if user.errors.empty?
          user.unlock_access! if unlockable?(user)
          sign_in resource_name, user
          return render status: :ok, json: user, serializer: UserSerializer
        else
          return render status: :forbidden, json: {success: false, error: user.errors.messages[:reset_password_token].first}
        end
      end

    end
  end
end