class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  has_one_attached :avatar
  has_many :circles
  has_many :affiliations
  has_many :affiliation_circles, through: :affiliations, source: :circle
  has_many :event_roles
  has_many :attendances

  include UuidGenerator
  before_create :default_avatar
  before_update :default_avatar

  def default_avatar
    if !avatar.attached?
      avatar.attach(io: File.open('app/assets/images/default_avatar.jpg'), filename: 'avatar_image.jpg')
    end
  end

  def circle_admin?(circle)
    circle_admins = []
    circle.affiliations.admin.each do |i|
      circle_admins << i.user
    end
    circle_admins.include?(self)
  end
end
