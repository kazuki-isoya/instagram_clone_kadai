class User < ApplicationRecord
  validate :name, presence: true, lenght: { maximum: 30}
  validate :email. presence: true, length: { maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase!}
end
