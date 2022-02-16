class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles
end
