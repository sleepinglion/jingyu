class Intro < ApplicationRecord
  belongs_to :user, :autosave=>true  
  validates_presence_of :title
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true  
  has_many :intro_photo, :foreign_key => :id, :dependent => :destroy
end
