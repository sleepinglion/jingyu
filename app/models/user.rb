class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,:omniauthable, omniauth_providers: [:kakao, :naver, :twitter, :facebook, :apple, :google_oauth2, :github]
  validates_presence_of :nickname
  validates_uniqueness_of :email

  has_many :notice, :dependent=> :destroy
  has_many :blog, :dependent=> :destroy
  has_many :gallery, :dependent=> :destroy

  has_many :user_authentications, dependent: :destroy
  has_many :user_pictures, dependent: :destroy

  accepts_nested_attributes_for :user_authentications, allow_destroy: true
  accepts_nested_attributes_for :user_pictures, :allow_destroy => true

  def self.create_from_omniauth(params)
    self.__send__(params.provider, params)
  end

  def remember_me
    super || false
  end

  def admin?
    admin
  end

  private

  def default_values
    self.name ||= '#'+SecureRandom.uuid
  end
end
