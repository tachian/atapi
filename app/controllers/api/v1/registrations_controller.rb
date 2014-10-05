module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      # Concerns for token_authenticable
      include TokenAuthentication

      prepend_before_action :require_no_authentication, only: [:create]
      prepend_before_action :authenticate_user_from_token!, only: [:edit, :update, :destroy]
      before_action :authenticate_user!, except: [:create]
      before_action :configure_permitted_parameters

      # Rails.logger.debug _process_action_callbacks.map{ |cb| [cb.filter, cb.options] }

      # POST /resource
      def create
        build_resource(sign_up_params)

        resource.skip_confirmation! 
        if resource.save
          if resource.active_for_authentication?
            sign_up resource_name, resource
            return render status: :ok, json: resource
          else
            expire_data_after_sign_in!
            return render status: :ok, json: nil
          end
        else
          clean_up_passwords resource
          return render status: :forbidden, json: {success: false, errors: resource.errors}
        end
      end

      # GET /resource
      def edit
        render json: current_user, serializer: Dashboard::ProfileSerializer
      end

      # PUT /resource
      # We need to use a copy of the resource because we don't want to change
      # the current user in place.
      def update

        # Check if it's an avatar being uploaded
        if request.content_type =~ /multipart/
          params[:user] = JSON(params[:user])
        end
        params[:user] = format_user_params(params)
        resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
        prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

        if needs_password?(resource, params)
          if resource.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
            if is_navigational_format?
              update_needs_confirmation?(resource, prev_unconfirmed_email)
            end
            sign_in resource_name, resource
            return render status: :ok, json: resource, serializer: UserSerializer
          else
            clean_up_passwords resource
            return render status: :forbidden, json: {errors: resource.errors}
          end
        else
          params[:user].delete(:current_password)
          if resource.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
            if is_navigational_format?
              update_needs_confirmation?(resource, prev_unconfirmed_email)
            end
            sign_in resource_name, resource
            return render status: :ok, json: resource, serializer: UserSerializer
          else
            clean_up_passwords resource
            return render status: :forbidden, json: {errors: resource.errors}
          end
        end
      end

      private

      def format_user_params(params)
        user_attributes = {}

        # Manipulating form data
        name = params[:user][:name].to_s unless params[:user][:name].nil?
        email = params[:user][:email].to_s.downcase unless params[:user][:email].nil?
        password = params[:user][:password].to_s unless params[:user][:password].nil?
        password_confirmation = params[:user][:password_confirmation].to_s unless params[:user][:password_confirmation].nil?
        current_password = params[:user][:current_password].to_s unless params[:user][:current_password].nil?
        birthday_ts = params[:user][:birthday_ts].to_i
        gender = params[:user][:gender].to_s
        occupation = params[:user][:occupation].to_s
        formation = params[:user][:formation].to_s
        job = params[:user][:job].to_s
        phone = params[:user][:phone].to_s
        about = params[:user][:about].to_s

        # Name
        user_attributes[:name] = name
        # Email
        user_attributes[:email] = email
        # Password
        user_attributes[:password] = password.blank? ? '' : password
        # Password confirmation
        user_attributes[:password_confirmation] = password_confirmation.blank? ? '' : password_confirmation
        # Current password
        user_attributes[:current_password] = current_password.blank? ? '' : current_password
        # Birthday
        user_attributes[:birthday] = Time.at(birthday_ts) unless birthday_ts.nil?
        # Gender
        user_attributes[:gender] = User.user_genders(gender.to_sym) unless gender.blank?
        # Occupation
        user_attributes[:occupation] = User.user_occupations(occupation.to_sym) unless occupation.blank?
        # Formation
        user_attributes[:formation] = User.user_formations(formation.to_sym) unless formation.blank?
        # Job
        user_attributes[:job] = User.user_jobs(job.to_sym) unless job.blank?
        # Phone
        user_attributes[:phone] = phone unless phone.blank?
        # About
        user_attributes[:about] = about unless about.blank?
        # Addresses
        user_attributes[:addresses_attributes] = []

        # User addresses may contain new States and Cities
        if params[:user][:addresses_attributes]
          params[:user][:addresses_attributes].each do |address|
            country_attributes = address[:country_attributes]
            state_attributes = address[:state_attributes]
            city_attributes = address[:city_attributes]

            if state_attributes[:id].nil?
              # New state
              state = State.create(country_id: country_attributes[:id], name: state_attributes[:name])
            else
              # Existing state
              state = State.where(country_id: country_attributes[:id], id: state_attributes[:id]).first
            end
            if city_attributes[:id].nil?
              # New city
              city = City.create(state_id: state.id, name: city_attributes[:name])
            else
              # Existing city
              city = City.where(state_id: state.id, id: city_attributes[:id]).first
            end
            # Associate address with city
            address[:city_id] = city.id
            # Remove support params
            address.delete(:country_attributes)
            address.delete(:state_attributes)
            address.delete(:city_attributes)
            # Add address to user
            user_attributes[:addresses_attributes]  << address
          end
        end

        # User documents
        if params[:user][:documents_attributes]
          # Add documents to user
          user_attributes[:documents_attributes] = params[:user][:documents_attributes]
        end        

        # Avatar is being uploaded?
        if params[:user][:avatar]
          user_attributes[:avatar] = params[:file]
        end

        user_attributes
      end

      private

      # check if we need password to update user data
      # if password or email was changed
      def needs_password?(user, params)
        user.email != params[:user][:email] || params[:user][:password].present?
      end

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) do |u|
          u.permit(:name, :email, :phone, :password, :password_confirmation)
        end
        devise_parameter_sanitizer.for(:account_update) do |u|
          u.permit(:name, :email, :password, :password_confirmation, :current_password, :occupation, :formation, :gender, :birthday, :email, :fb_id, :job, :phone, :about, :avatar, addresses_attributes: [:id, :city_id, :street, :number, :district, :complement, :postalcode], documents_attributes: [:id, :name, :value])
        end
      end

    end
  end
end
