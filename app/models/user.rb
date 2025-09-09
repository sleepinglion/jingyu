class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatables
  validates_presence_of :nickname
  validates_uniqueness_of :email
  has_many :user_photo, :dependent=> :destroy
  has_many :notice, :dependent=> :destroy
  has_many :blog, :dependent=> :destroy
  has_many :gallery, :dependent=> :destroy

  has_one :user_picture, dependent: :destroy
  accepts_nested_attributes_for :user_picture, allow_destroy: true

  def remember_me
    super || false
  end

  def admin?
    admin
  end
end
