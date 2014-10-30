module Api
  module V1
    class UnisebMailer < ActionMailer::Base
      default :from => "\"Veduca\" <info@veduca.com.br>"

      def subscribed(mba_user)
        mail_for mba_user, 'Sua pré-matrícula no MBA Engenharia e Inovação está concluída'
      end

      def payment_remainder(mba_user, codigo_aluno)
        @invoices = ::Uniseb::Retrieve.installments(codigo_aluno)
        @mba_user = mba_user
        @codigo_aluno = codigo_aluno
        mail_for mba_user, 'MBA em Engenharia e Inovação - Boleto para pagamento'.html_safe
      end

      def welcome(mba_user)
        mail_for mba_user, 'Bem-vindo(a) ao MBA Engenharia e Inovação'
      end

      private 

      def mail_for(mba_user, subject)
        @mba_user = mba_user
        mail(to: @mba_user.email, bcc: "carlos.souza@veduca.com.br,marcelo.mejla@veduca.com.br,cristian.medeiros@veduca.com.br,ana.lima@veduca.com.br", subject: subject)
      end
    end
  end
end
