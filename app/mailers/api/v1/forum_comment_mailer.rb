module Api
  module V1
    class ForumCommentMailer < ActionMailer::Base
      default :from => "\"Veduca\" <info@veduca.com.br>"

      def report(email_to, name_from, comment, personal_message = nil)
        @user_name = name_from
        @email_to = email_to
        @comment = comment
        mail(to: @email_to, subject: "Denuncia de Comentário de Fórum")
      end
    end
  end
end