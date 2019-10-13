class NickoneillSesMailer < ApplicationMailer
    FROM_EMAIL = "\"Nick O'Neill\" <holler@nickoneill.com>"
    self.smtp_settings = {
        :address => 'email-smtp.us-east-1.amazonaws.com',
        :port => 587,
        :domain => 'nickoneill.com',
        :authentication => 'plain',
        user_name:  Rails.application.credentials.dig(:ses_smtp, :username),
        password:   Rails.application.credentials.dig(:ses_smtp, :password),
        :enable_starttls_auto => true
    }

    def from_email
        FROM_EMAIL
    end

    def test_mailer(contact_id, subject = "Test email")
        @contact = Contact.find(contact_id)
        mail(
            to: @contact.primary_email,
            from: FROM_EMAIL,
            subject: subject
        )
    end
end
