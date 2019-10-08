class GmailMailer < ApplicationMailer
    self.delivery_method = Rails.env.test? ? :test : :smtp 
    self.smtp_settings = {
        address:   'smtp.gmail.com',
        port:      587,
        user_name:  Rails.application.credentials.dig(:gmail, :username),
        password:   Rails.application.credentials.dig(:gmail, :password)
    }

    def invite_email(contact_id)
        @contact = Contact.find(contact_id)
        mail(
            to: @contact.primary_email,
            from: "\"Nick O'Neill\" <holler@nickoneill.com>",
            subject: "Experiment project launch!"
        )
    end
end
