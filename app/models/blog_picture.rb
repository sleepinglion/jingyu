class BlogPicture < ApplicationRecord
  belongs_to :blog, autosave: true, counter_cache: true
  mount_uploader :picture, BlogPictureUploader
end
