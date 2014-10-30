module Api
  module V1
    class MbaContactMailer < ActionMailer::Base
      default :from => "\"Veduca\" <info@veduca.com.br>", to: "mba@veduca.com.br"

      def contact(email, name, phone, subject, body)
        @email = email
        @name = name
        @phone = phone
        @body_email = body
        mail(reply_to: email, subject: "Contato Landing Page: #{subject}")
      end
    end
  end
end
