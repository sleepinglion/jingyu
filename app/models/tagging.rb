class Tagging < ApplicationRecord
  belongs_to :tag, :counter_cache => true
end
