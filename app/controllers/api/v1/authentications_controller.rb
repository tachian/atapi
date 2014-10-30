module Api
  module V1
    class AuthenticationsController < Devise::SessionsController

       # Concerns for token_authenticable
      include TokenAuthentication

      skip_before_action :authenticate_user_from_token!, only: [:create]
      before_action :authenticate_user!, except: [:create]

      def create
        user_data = params[:user_data]
        user_credentials = user_data[:credentials]
        user_info = user_data[:info]
        
        username = user_info[:username]
        email = user_info[:email]
        access_token = user_credentials[:accessToken]
        formation = user_info[:education]
        address = user_info[:location]
        avatar_url = user_info[:avatar]

        user = User.where(fb_id: user_info[:id]).first # User exists with provided FB uid?
        if user.nil? && !email.blank?
          user = User.where(email: email.downcase).first # User exists with provided FB email?
        end
        if user.nil? && !username.blank?
          user = User.where(email: username.downcase + '@facebook.com').first # User exists with provided defdault FB email?
        end

        if user.nil?
          user = User.new
          user.skip_confirmation!
          
          # Base data
          user.name = user_info[:name]
          user.gender = user_info[:gender].downcase
          user.provider = 'facebook'
          user.fb_id = user_info[:id]
          user.fb_at = access_token
          # Credentials
          user.email = email || username.downcase + '@facebook.com'
          user.password = Devise.friendly_token.first(8)
          # Profile data
          user.birthday = Date.strptime(user_info[:birthday], '%m/%d/%Y') unless user_info[:birthday].blank?
          # user.remote_avatar_url = avatar_url
          user.ensure_authentication_token

          user.remember_me = true
          
          user.save
          sign_in(:user, user)
          Api::V1::RegistrationMailer.new_account(user).deliver
        else
          user.provider = 'facebook'
          user.fb_id = user_info[:id]
          user.fb_at = access_token
          user.remember_me = true

          if user.encrypted_password.nil?
            user.password = Devise.friendly_token.first(8)

            if user.legacy_password_hash.present? && user.legacy_password_salt.present?
              user.legacy_password_hash = nil
              user.legacy_password_salt = nil
            end

            user.save
          end
          sign_in(:user, user)
        end

        return render status: :ok, json: user, serializer: UserSerializer
      end

      def impersonate
        return render status: :forbidden, json: {success: false, error: 'authentication failed'}
      end

    end
  end
end
