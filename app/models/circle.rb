class Circle < ApplicationRecord
  has_one_attached :top_image
  has_many_attached :other_images
  belongs_to :user
  has_many :affiliations, dependent: :destroy
  has_many :affiliation_user, through: :affiliations, source: :user
  has_many :events, dependent: :destroy
  has_many :circle_roles, dependent: :destroy

  validates :name, presence: true
  validates :introduction, length: { maximum: 65_535 }
  validates :state, presence: true

  enum state: { unpublish: 0, publish: 1 }

  before_create :default_top_image
  after_create :create_affilication
  before_update :default_top_image

  include UuidGenerator

  def default_top_image
    unless top_image.attached?
      top_image.attach(io: File.open('app/assets/images/default_top_image.jpg'), filename: 'default_top_image.jpg')
    end
  end

  def create_affilication
    affiliations.create(user_id: user_id, circle_state: :admin)
  end
end
