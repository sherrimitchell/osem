module Admin
  class RoomEventsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :program, through: :conference, singleton: true
    load_resource :venue, through: :conference, singleton: true
    load_and_authorize_resource :event, through: :program
    load_and_authorize_resource :room
    load_and_authorize_resource :event, through: :room

    before_action :get_room, only: [:show]
    before_action :get_all_rooms, only: [:index]

    def index
    end

    def show
      @event = @room.current_event || @room.next_event || @room.canceled_event
    end

## Todo: 
# If an event is cancelled, then display the event on the screen
# If no events are scheduled in a room after the current event, then display conference-wide screen
# Add page refresh

    private

    def get_room
      @room = Room.find(params[:id])
    end

    def get_all_rooms
      @rooms = @venue.rooms
    end
  end
end
