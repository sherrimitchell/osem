class EventSchedule < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :event
  belongs_to :room

  validates :schedule, presence: true
  validates :event, presence: true
  validates :room, presence: true
  validates :start_time, presence: true
  validates :event, uniqueness: { scope: :schedule }

  scope :confirmed, -> { joins(:event).where('state = ?', 'confirmed') }
  scope :canceled, -> { joins(:event).where('state = ?', 'canceled') }
  scope :withdrawn, -> { joins(:event).where('state = ?', 'withdrawn') }

  delegate :guid, to: :room, prefix: true

  ##
  # Returns end of the event
  #
  def end_time
    start_time + event.event_type.length.minutes
  end

  ##
  # Returns events that are scheduled in the same room and start_time as event
  #
  def intersecting_events
    room.event_schedules.where(start_time: start_time, schedule: schedule).where.not(id: id)
  end

  ##
  # Checks if the event is the current event
  ##
  def current
    @event_schedules = @schedule.event_schedules
    @event_schedule = @event_schedules.find(params[:id])
    if @event_schedule.id == @schedule.program.selected_schedule_id
      true
    else
      false

      
        event_schedule = @event_schedule
    if event_schedule.start_time <= DateTime.current && DateTime.current <= event_schedule.end_time
      true
    else
      false
    end
  end
  end
    

    # a current event is confirmed or canceled
    # end_time > start_time
    # event_schedule - if schedule.program.selected_schedule.id == schedule.id
    # 
  
end
# current event schedule
# if event schedule has the same 
# EventScheduleId
#   start time
# as
# @schedule.program.selected_schedule.event_schedules
#   EventScheduleId
#   start time
# EventSchedule.where('schedule_id = ?', @schedule.program.selected_schedule_id)
# if schedule.program.selected_schedule == schedule //then our event schedule is in the selected schedule
