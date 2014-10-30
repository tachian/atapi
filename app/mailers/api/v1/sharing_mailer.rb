module Api
  module V1
    class SharingMailer < ActionMailer::Base
      default :from => "\"Veduca\" <info@veduca.com.br>"

      def email(link_to, email_to, name_from, lecture, personal_message = nil)
        @link_to = link_to
        @user_name = name_from || "seu amigo"
        @email_to = email_to
        @lecture = lecture
        @personal_message = personal_message

        mail(to: @email_to, subject: "Assista ao vídeo no Veduca")
      end
    end
  end
end
