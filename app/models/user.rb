class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatables
  validates_presence_of :nickname
  validates_uniqueness_of :email
  mount_uploader :photo, UserUploader
  has_many :user_photo, :dependent=> :destroy
  has_many :notice, :dependent=> :destroy
  has_many :blog, :dependent=> :destroy
  has_many :gallery, :dependent=> :destroy
end
