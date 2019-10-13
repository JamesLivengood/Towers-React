require 'rails_helper'

RSpec.describe Contacts::Unsubscribe, type: :service do
    let (:contact) { create(:contact, unsubscribed_at: nil) }
    let (:service) { Contacts::Unsubscribe.new(contact: contact) }

    describe '#perform' do
        it 'updates the unsubscribed to the current time' do
            service.perform
            expect(contact.reload.unsubscribed_at).not_to be_nil
        end
    end

    describe '.run' do
        it "performs the processing" do
            allow(Contacts::Unsubscribe).to receive(:new).and_return(service)
            expect(service).to receive(:perform)
            Contacts::Unsubscribe.run(contact)
        end
    end
end