class Circle < ApplicationRecord
  has_one_attached :top_image
  has_many_attached :other_images
  belongs_to :user
  has_many :affiliations

  before_create :default_top_image

  def default_top_image
    if !self.top_image.attached?
      self.top_image.attach(io: File.open('app/assets/images/default_top_image.jpg'), filename: 'default_top_image.jpg')
    end
  end
end
