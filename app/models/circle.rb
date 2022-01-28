class Circle < ApplicationRecord
  has_one_attached :top_image
  has_many_attached :other_images
  belongs_to :user
  has_many :affiliations

end
