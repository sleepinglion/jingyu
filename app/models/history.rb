class History < ActiveRecord::Base
  validates_presence_of :year, :title
  belongs_to :user,:autosave=>true
end
