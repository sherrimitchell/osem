<<<<<<< ours
require 'spec_helper'

describe Admin::RoomEventPagesController do
  let!(:admin) { create(:admin) }
  let!(:conference) { create(:conference, short_title: 'testconf') }
  let!(:venue) { create(:venue, conference: conference) }
  let!(:program) { create(:program, conference: conference) }
  let!(:room) { create(:room, venue: venue, size: 4) }
  let!(:event) { create(:event, program: program, room: room, start_time: DateTime.current) }
  let!(:last_event) { create(:event, room: room, start_time: DateTime.current - 1.hour) }
  let!(:next_event) { create(:event, room: room, start_time: DateTime.current + 1.hour) }

  context 'admin is signed in' do
    before { sign_in admin }
##  Create a next and last event in before
##  Add a new test that says you get a next event if there is no current event
    describe 'GET #show' do
      before { get :show, id: room.id, conference_id: 'testconf' }

      it 'assigns conference, venue and rooms variables' do
        expect(assigns(:conference)).to eq conference
        expect(assigns(:venue)).to eq venue
        expect(assigns(:room)).to eq room
        expect(assigns(:event)).to eq event
      end

      it 'gets the current event for a specific room' do
        expect(room.current_event.id).to eq room.current_event.id
      end
      ## current event
      it 'returns an event that is currently going on' do
        expect(room.current_event.id).to eq event.id
      end
      it 'returns true for the current event' do
        expect(event.current?).to be_truthy
      end
      ## next event
      it 'returns false for the next event' do
        expect(next_event.current?).to be_falsey
      end
      it 'returns the next_event if there is no event currently going on' do
        expect(room.next_event.id).to eq next_event.id
      end
      ## last event
      it 'returns false for the last event' do
        expect(last_event.current?).to be_falsey
      end
    end
  end
end
||||||| base
=======
require 'spec_helper'

describe Admin::RoomEventPagesController do
  let!(:admin) { create(:admin) }
  let!(:conference) { create(:conference, short_title: "testconf") }
  let!(:venue) { create(:venue, conference: conference) }
  let!(:program) { create(:program, conference: conference) }
  let!(:room) { create(:room, venue: venue, size: 4) }
  let!(:event) { create(:event, program: program, room: room, start_time: DateTime.current) }
  let!(:last_event) { create(:event, room: room, start_time: DateTime.current - 1.hour) }
  let!(:next_event) { create(:event, room: room, start_time: DateTime.current + 1.hour) }

  context 'admin is signed in' do
    before { sign_in admin }
## Create a next and last event in before
## Add a new test that says you get a next event if there is no current event
    describe 'GET #show' do
      before { get :show, id: room.id, conference_id: "testconf" }

      it 'assigns conference, venue and rooms variables' do
        expect(assigns(:conference)).to eq conference
        expect(assigns(:venue)).to eq venue
        expect(assigns(:room)).to eq room
        expect(assigns(:event)).to eq event
      end

      it 'gets the current event for a specific room' do
        expect(room.current_event.id).to eq room.current_event.id
      end
      ## current event
      it 'returns an event that is currently going on' do
        expect(room.current_event.id).to eq event.id
      end
      it 'returns true for the current event' do
        expect(event.is_current?).to be_truthy
      end
      ## next event
      it 'returns false for the next event' do
        expect(next_event.is_current?).to be_falsey
      end
      it 'returns the next_event if there is no event currently going on' do
        expect(room.next_event.id).to eq next_event.id
      end
      ## last event
      it 'returns false for the last event' do
        expect(last_event.is_current?).to be_falsey
      end
    end
  end
end

      

      

      

      
>>>>>>> theirs
