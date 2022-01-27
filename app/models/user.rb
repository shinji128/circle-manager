class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_one_attached :avatar
  has_many :circles
  has_many :circle
  has_many :user_circles
  has_many :join_circles, through: :user_circles, source: :circle

  include UuidGenerator

  def circlejoin(circle)
    join_circles << circle
  end
end
