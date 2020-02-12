class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30}
  validates :email, presence: true, length: { maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  before_validation { email.downcase!}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :feeds
  has_many :favorites, dependent: :destroy
  has_many :favorite_feeds, through: :favorites, source: :feed
  mount_uploader :image, ImageUploader

  #リレーションシップを作っている
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
