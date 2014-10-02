Doorkeeper.configure do
  # Change the ORM that doorkeeper will use.
  # Currently supported options are :active_record, :mongoid2, :mongoid3, :mongo_mapper
  orm :active_record

  # Limit client credentials request to only accept parameters (no Basic Auth)
  client_credentials :from_params # Limited

  # This block will be called to check whether the resource owner is authenticated or not.
  # resource_owner_authenticator do
  #   current_user || warden.authenticate!(:scope => :user)
  # end

  # skip_authorization do |resource_owner, client|
  #   client.superapp? || resource_owner.admin?
  # end

  # Access token expiration time (default 2 hours)
  if Rails.env.production?
    access_token_expires_in 2.hours
  end
  if Rails.env.development? || Rails.env.test?
    access_token_expires_in 10.minutes
  end

  # Authorization code expiration time
  authorization_code_expires_in 10.minutes

  # Issue access tokens with refresh token (disabled by default)
  # use_refresh_token

  # Define access token scopes for your provider
  # For more information go to https://github.com/applicake/doorkeeper/wiki/Using-Scopes
  default_scopes  :public
  optional_scopes :admin, :user, :vendor
end
