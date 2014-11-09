module Api
  module V1
    class ConfirmationsController < Devise::ConfirmationsController
      # GET /resource/confirmation/new
      def new
        self.resource = resource_class.new
      end

      # POST /resource/confirmation
      def confirm
        resource = resource_class.confirm_by_token(params[:confirmation_token])

        if resource.errors.empty?
          return render status: :ok, json: {success: true}
        else
          return render status: :forbidden, json: {success: false, errors: resource.errors}
        end
      end

      # POST /confirmations/resend
      def resend
        if params[:user][:email]
          self.resource = User.where(email: params[:user][:email]).first
          self.resource.send_confirmation_instructions
          return render status: :ok, json: {success: true}
        else
          return render status: :forbidden, json: {success: false, error: 'authentication failed'}
        end
      end

    end
  end
end