class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  has_one_attached :avatar
  has_many :circles

  include UuidGenerator
  before_create :default_avatar

  def default_avatar
    if !avatar.attached?
      avatar.attach(io: File.open('app/assets/images/default_avatar.jpg'), filename: 'avatar_image.jpg')
    end
  end
end
