class IntroPhoto < ApplicationRecord
  validates_presence_of :photo, :alt
  belongs_to :intro, :autosave=>true
  accepts_nested_attributes_for :intro, :allow_destroy => true
  mount_uploader :photo, IntroPhotoUploader
end
