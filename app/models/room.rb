class Room < ActiveRecord::Base
  belongs_to :venue
  has_many :event_schedules, dependent: :nullify

  has_paper_trail ignore: [:guid], meta: { conference_id: :conference_id }
  
  before_create :generate_guid

  validates :name, :venue_id, presence: true

  validates :size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  def scheduled_events
    
  end

  def current_event
    events.find(&:current?)
  end

  def next_event
    events.sort_by(&:start_time).find { |e| e.start_time > DateTime.current }
  end

  def canceled_events
    events.canceled
  end

  private

  def generate_guid
    guid = SecureRandom.urlsafe_base64
    self.guid = guid
  end

  def conference_id
    venue.conference_id
  end
end
