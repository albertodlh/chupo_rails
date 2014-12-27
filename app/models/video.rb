class Video < ActiveRecord::Base
  validates :title, presence: true
  validates :youtube_id, presence: true
end
