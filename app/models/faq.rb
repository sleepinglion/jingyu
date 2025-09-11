class Faq < ApplicationRecord
  is_impressionable
  has_rich_text :content

  validates_presence_of :title
  belongs_to :faq_category, :autosave=>true
end
