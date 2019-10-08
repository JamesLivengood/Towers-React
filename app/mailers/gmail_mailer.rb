class GmailMailer < ApplicationMailer
    self.smtp_settings = {
        :address => 'smtp.gmail.com',
        :port => 587,
        :domain => 'gmail.com',
        :authentication => 'plain',
        user_name:  Rails.application.credentials.dig(:gmail, :username),
        password:   Rails.application.credentials.dig(:gmail, :password),
        :enable_starttls_auto => true
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
