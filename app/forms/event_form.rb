class EventForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :event
  attribute :event_role
  attribute :event_roles
  attribute :name, :string
  attribute :place, :string
  attribute :event_fee, :integer
  attribute :event_at, :datetime
  attribute :event_time, :time
  attribute :people_limit_num, :integer
  attribute :limit_answer_at, :datetime
  attribute :note, :string
  attribute :circle_id, :integer
  attribute :user_id, :integer

  validates :name, presence: true

  delegate :persisted?, to: :@event

  def initialize(attributes = nil, event: Event.new)
    @event = event
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return false if invalid?

    self.event = Event.new(event_params)
    event.uuid = loop do
      uuid = SecureRandom.uuid
      break uuid unless Event.exists?(uuid: uuid)
    end
    event.save
    if event_role
      event_role.each do |i|
        event.event_roles.create!(name: i['name'], user_id: i['user_id'].to_i)
      end
    end
    true
  end

  def update
    ActiveRecord::Base.transaction do
      if event_role.present?
        event_role.each do |i|
          @event.event_roles.create!(name: i['name'], user_id: i['user_id'].to_i)
        end
      end
      @event.update!(event_params)
    end
  end

  def to_model
    @event
  end

  private

  def event_params
    {
      name: name,
      place: place,
      event_fee: event_fee,
      event_at: event_at,
      event_time: event_time,
      people_limit_num: people_limit_num,
      limit_answer_at: limit_answer_at,
      note: note,
      circle_id: circle_id
    }
  end

  def default_attributes
    {
      name: @event.name,
      place: @event.place,
      event_fee: @event.event_fee,
      event_at: @event.event_at,
      event_time: @event.event_time,
      people_limit_num: @event.people_limit_num,
      limit_answer_at: @event.limit_answer_at,
      note: @event.note,
      circle_id: @event.circle_id,
      event_roles: @event.event_roles
    }
  end
end
