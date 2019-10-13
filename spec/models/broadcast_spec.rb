require 'rails_helper'

RSpec.describe Broadcast, type: :model do
  it { should respond_to(:tags) }
  it { should respond_to(:send_at) }
  it { should respond_to(:markdown_body) }
  it { should respond_to(:subject) }

  html_markdown = "Hey {{first_name}},

How you doing?"

  describe '#html_for_contact' do
    let(:contact) { create(:contact) }
    let(:broadcast) { create(:broadcast, markdown_body: html_markdown) }

    it "returns properly parsed HTML" do
      expect(broadcast.html_for_contact(contact)).to eq "<p>Hey #{contact.first_name},</p>\n\n<p>How you doing?</p>\n"
    end
  end
end
