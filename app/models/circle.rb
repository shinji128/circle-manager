class Circle < ApplicationRecord
  has_one_attached :top_image
  has_many_attached :other_images
  belongs_to :user
  has_many :affiliations
  has_many :affiliation_user, through: :affiliations, source: :user
  has_many :events
  has_many :circle_roles

  validates :name, presence: true
  validates :introduction, length: { maximum: 65_535 }
  validates :state, presence: true

  enum state: { unpublish: 0, publish: 1 }

  before_create :default_top_image
  before_update :default_top_image

  include UuidGenerator

  def default_top_image
    if !top_image.attached?
      top_image.attach(io: File.open('app/assets/images/default_top_image.jpg'), filename: 'default_top_image.jpg')
    end
  end

  def circle_member?(current_user)
    self.affiliations.pluck(:user_id).include?(current_user.id)
  end
end
