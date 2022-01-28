class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  has_one_attached :avatar
  has_many :circles

  include UuidGenerator
end
