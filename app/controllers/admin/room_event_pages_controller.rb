module Admin
  class RoomEventPagesController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :program, through: :conference, singleton: true
    load_resource :venue, through: :conference, singleton: true
    load_and_authorize_resource :event, through: :program
    load_and_authorize_resource :room
    load_and_authorize_resource :event, through: :room

    before_action :get_room

    def show
      @event = @room.current_event || @room.next_event
    end

## Todo: Create a page that displays when no events are available

    private

    def get_room
      @room = Room.find(params[:id])
    end
  end
end
