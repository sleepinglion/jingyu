class UserPicture < ApplicationRecord
  belongs_to :user, counter_cache: true
  mount_uploader :picture, UserPictureUploader
end
