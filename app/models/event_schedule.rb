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

  def current?
    self.schedule_id == program.selected_schedule.id
  end

  def event_current?
    start_time == DateTime.current && start_time < end_time
  end
    ##
    # start_time <= current_time 
    
    # a current event is confirmed or canceled
    # end_time > start_time
    # event_schedule - if schedule.program.selected_schedule.id == schedule.id
    # 
  
end


# if schedule.program.selected_schedule == schedule //then our event schedule is in the selected schedule
