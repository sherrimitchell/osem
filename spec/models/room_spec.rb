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
    it { should have_many(:event_schedules).dependent(:nullify) }
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
    let!(:canceled_event) {create(:event, room: subject, start_time: DateTime.current + 1.hour, state: 'canceled') }

    it 'returns an event that is currently going on' do
      expect(subject.current_event.id).to eq event.id
    end

    it 'returns the next_event if there is no event currently going on' do
      expect(subject.next_event.id).to eq next_event.id
    end

    it 'returns the canceled event if there is no event currently going on and the next_event is canceled' do
      expect(subject.canceled_event.id).to eq canceled_event.id
    end
  end
end
