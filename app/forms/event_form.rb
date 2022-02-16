class EventForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :event
  attribute :event_role
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

  def save
    return false if invalid?

    self.event = Event.create!(event_params)
    event_role.each do |r|
      event.event_roles.create!(name: r["name"], user_id: r["user_id"].to_i)
    end
    true
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
end
