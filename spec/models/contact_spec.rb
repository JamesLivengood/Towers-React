require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:description_markdown) }
  it { should respond_to(:primary_email) }
  it { should respond_to(:secondary_emails) }
  it { should respond_to(:phone) }
  it { should respond_to(:last_proactive_outreach) }
  it { should respond_to(:last_inbound_message) }
  it { should respond_to(:linkedin) }
  it { should respond_to(:twitter) }
  it { should respond_to(:instagram) }

  describe '#to_h' do
    let(:contact) { create(:contact) }

    it 'includes the email' do
      expect(contact.to_h['email']).to eq contact.primary_email
    end

    it 'includes first_name' do
      expect(contact.to_h['first_name']).to eq contact.first_name
    end

    it 'includes last_name' do
      expect(contact.to_h['last_name']).to eq contact.last_name
    end

    it 'returns the unsubscribe_url'
  end

  it "generates an unsubscribe key on creation" do
    c = create(:contact)
    expect(c.unsubscribe_key).not_to be nil
  end

  it "splits comma separated tags" do
    c = Contact.new(tags: 'one,two,three')
    expect(c.tags).to eq ['one', 'two', 'three']
  end
end
