class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles
  has_many :attendances
end
