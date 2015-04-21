module Api
  module V1
    class RegistrationMailer < ActionMailer::Base
      default :from => "\"Tulupa\" <contato@tulupa.com.br>"

      def new_account(user)
      	@user = user
        mail(to: user.email, subject: 'Sua conta foi criada no Tulupa.')
      end
    end
  end
end
