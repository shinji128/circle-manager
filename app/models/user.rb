class User < ApplicationRecord
  has_one_attached :avatar

  include UuidGenerator
end
