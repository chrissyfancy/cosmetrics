class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews
  has_many :votes, dependent: :destroy
  validates :email, uniqueness: true
  accepts_nested_attributes_for :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePhotoUploader

  def is_admin?
    role == 'admin'
  end
end
