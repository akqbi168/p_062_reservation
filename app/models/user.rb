class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :user_icon, ImageUploader

  has_many :properties
  has_one :cart, dependent: :destroy
  has_many :reservations
  has_many :reputations
  has_many :favorites

  POSTAL_CODE_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  with_options presence: true do
    validates :name, length: {maximum: 32}
    validates :email, format: { with: POSTAL_CODE_REGEX }
  end
end
