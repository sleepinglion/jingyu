class Blog < ApplicationRecord
  is_impressionable
  acts_as_taggable
  acts_as_commentable
  acts_as_votable
  has_rich_text :content
  #ActsAsTaggableOn.delimiter = ','
  #ActsAsTaggableOn.force_lowercase = true
  validates_presence_of :title, :description
  validates_length_of :title, :minimum => 2, :maximum => 60
  belongs_to :user
  belongs_to :blog_category, :autosave => true, :counter_cache => true
  has_one :blog_picture, dependent: :destroy
  accepts_nested_attributes_for :blog_picture, :allow_destroy => true
end
