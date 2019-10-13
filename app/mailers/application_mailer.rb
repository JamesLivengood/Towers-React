class ApplicationMailer < ActionMailer::Base
  default from: '"Nick O\'Neill" <holler@nickoneill.com>'
  layout 'mailer'

  def broadcast(contact_id, broadcast_id)
    @contact = Contact.find(contact_id)
    @broadcast = Broadcast.find(broadcast_id)
    mail(
      to: @contact.primary_email,
      from: from_email,
      subject: @broadcast.subject
    )
  end
end
