require 'spec_helper'

describe EventSchedule do
  subject { create(:event_schedule) }
  let(:conference) { create(:conference) }
  let(:program) { create(:program) }
  let(:schedule) { create(:schedule) }
  let(:event) { create(:event) }
  let(:room) { create(:room) }
  let(:event_schedule) { create(:event_schedule, program: conference.program.selected_schedule.event_schedule) }

  describe 'association' do
    it { should belong_to(:schedule) }
    it { should belong_to(:event) }
    it { should belong_to(:room) }
  end

  describe 'validation' do
    it 'has a valid factory' do
      expect(build(:event_schedule)).to be_valid
    end

    it { is_expected.to validate_presence_of(:schedule) }
    it { is_expected.to validate_presence_of(:event) }
    it { is_expected.to validate_presence_of(:room) }
    it { is_expected.to validate_presence_of(:start_time) }
  end

  describe '#current?' do
    context 'self.current?'
    it 'returns true for the current event_schedule' do
      expect(subject.current?).to be_truthy
    end

    it 'returns false for the next event_schedule' do
      expect(subject.next?).to be_falsey
    end
  end
end
