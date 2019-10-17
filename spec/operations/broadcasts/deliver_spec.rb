require 'rails_helper'

RSpec.describe Broadcasts::Deliver, type: :service do
    let(:service) { Broadcasts::Deliver.new(broadcast: broadcast) }
    let(:broadcast) { create(:broadcast) }
    
    before do
        @contact = create(:contact, subscribed_at: DateTime.current, unsubscribed_at: nil)
    end

    describe '#perform' do
        it 'delivers to active subscribers' do
            expect(NickoneillSesMailer).to receive(:broadcast).with(@contact.id, broadcast.id).and_return(OpenStruct.new({deliver_later: true}))
            service.perform
        end

        it 'updates the broadcast to be sent'
    end

    describe '.run' do
        it "performs the processing" do
            allow(Broadcasts::Deliver).to receive(:new).and_return(service)
            expect(service).to receive(:perform)
            Broadcasts::Deliver.run(@contact)
        end
    end
end