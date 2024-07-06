class Gallery < ApplicationRecord
  is_impressionable
  acts_as_taggable
  validates_presence_of :title
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true
  belongs_to :gallery_category, :autosave => true, :counter_cache => true
  mount_uploader :photo, GalleryUploader
end
