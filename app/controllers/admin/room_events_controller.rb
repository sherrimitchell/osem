module Admin
  class RoomEventsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :program, through: :conference, singleton: true
    load_resource :venue, through: :conference, singleton: true
    load_and_authorize_resource :event, through: :program
    load_and_authorize_resource :room
    load_and_authorize_resource :event, through: :room

    before_action :room, only: [:show]
    before_action :rooms, only: [:index]

    def index
    end

    def show
      @event = @room.current_event || @room.next_event
      if @event.nil?
        render json: { message: 'No event available. This is a temporary measure until I can get the rest of the code I need.' },
        status: :unprocessable_entity
      else
        respond_to do |format|
        format.html { render layout: 'room_events'}
        # format.js  { render action: 'osem-update-room-events'}      
        end
      end
    end
## Todo:
    #  If no events are scheduled in a room after the current event, then display conference-wide screen
    #  Add page refresh

    private

    def room
      @room = Room.find(params[:id])
    end

    def rooms
      @rooms = @venue.rooms
    end
  end
end
