class Circle < ApplicationRecord
  has_one_attached :top_image
  has_many_attached :other_images
  has_many :user_circles
  belongs_to :user

  include UuidGenerator
end
