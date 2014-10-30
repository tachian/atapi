module Api
  module V1
    class EnrollmentMailer < ActionMailer::Base
      default :from => "\"Veduca\" <info@veduca.com.br>"

      def subscribed(course_info, user_mail)
        @course_info = course_info
        mail(to: user_mail, subject: 'Inscrição no curso realizada!')
      end

      def scheduled(enrollment)
        @enrollment = enrollment
        mail(to: @enrollment.user.email, subject: 'Agendamento de prova realizado')
      end
    end
  end
end
