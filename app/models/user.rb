class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews
  has_many :votes, dependent: :destroy

  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, inclusion: { in: %w(member admin) }

  accepts_nested_attributes_for :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePhotoUploader

  def is_admin?
    role == 'admin'
  end
end
