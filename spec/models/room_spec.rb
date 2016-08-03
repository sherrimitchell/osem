require 'spec_helper'

describe Room do
  subject { create(:room) }

  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:venue_id) }
    it { should validate_numericality_of(:size).only_integer.is_greater_than(0).allow_nil }
  end

  describe 'association' do
    it { should belong_to(:venue) }
    it { should have_many(:events).dependent(:nullify) }
  end

  describe 'callback' do
    after { subject.run_callbacks(:create) }

    it '#generate_guid' do
      regex_base64 = %r{^(?:[A-Za-z_\-0-9+\/]{4}\n?)*(?:[A-Za-z_\-0-9+\/]{2}|[A-Za-z_\-0-9+\/]{3}=)?$}
      expect(subject).to receive(:generate_guid)
      expect(subject.guid).to match regex_base64
    end
  end

  describe 'current event' do
    let!(:event) { create(:event, room: subject, start_time: DateTime.current)}
    let!(:last_event) { create(:event, room: subject, start_time: DateTime.current - 1.hour) }
    let!(:next_event) { create(:event, room: subject, start_time: DateTime.current + 1.hour) }


      it 'returns false for the last event' do
        expect(last_event.is_current?).to be_falsey
      end

      it 'returns false for the next event' do
        expect(next_event.is_current?).to be_falsey
      end

      it 'returns true for the current event' do
        expect(event.is_current?).to be_truthy
      end

      it 'returns an event that is currently going on' do
        expect(subject.current_event.id).to eq event.id
      end

      it 'returns the next_event if there is no event currently going on' do
        expect(subject.next_event.id).to eq next_event.id
      end
  
    ### Todo: Copy this code into the room spec and use for the current event test
  end

  ## Todo:
  ### No current event, returns nil
  ### If there is  a current event, return the event
  ### In the before block only create the current event in the block where I want it to be returned. Don't use the before block that I have as-is in the event test.
end
