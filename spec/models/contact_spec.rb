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

  it "generates an unsubscribe key on creation" do
    c = create(:contact)
    expect(c.unsubscribe_key).not_to be nil
  end

  it "splits comma separated tags" do
    c = Contact.new(tags: 'one,two,three')
    expect(c.tags).to eq ['one', 'two', 'three']
  end
end
