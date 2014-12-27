class Article < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :pubdate, presence: true
end
