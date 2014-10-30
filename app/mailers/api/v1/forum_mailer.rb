module Api
  module V1
    class ForumMailer < ActionMailer::Base
      default :from => "\"Veduca\" <info@veduca.com.br>"

      def report(email_to, name_from, forum, personal_message = nil)
        @user_name = name_from
        @email_to = email_to
        @forum = forum
        mail(to: @email_to, subject: "Denuncia de Fórum")
      end
    end
  end
end
