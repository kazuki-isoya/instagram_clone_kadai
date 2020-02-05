class Feed < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :favorites
  has_many :users, through: :favorites

  validates :image, presence: true
  validates :content, presence: true
end
