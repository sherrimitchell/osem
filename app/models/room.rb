class Room < ActiveRecord::Base
  belongs_to :venue
  has_many :events, dependent: :nullify
  

  before_create :generate_guid

  validates :name, :venue_id, presence: true

  validates :size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  def current_event
    events.find { |e| e.is_current? }
  end

  def next_event
    events.sort_by(&:start_time).find { |e| e.start_time > DateTime.current } 
  end

  private

  def generate_guid
    guid = SecureRandom.urlsafe_base64
    self.guid = guid
  end
end
