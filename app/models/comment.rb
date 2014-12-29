class Comment < ActiveRecord::Base
  validates :user, presence: true
  validates :pubdate, presence: true
  validates :content, presence: true
  validates :status, presence: true

  before_save :create_gravatar_url
  after_initialize :set_pubdate

  def status_enum
    [['Published', 'P'], ['Reviewing', 'R'], ['Hidden', 'H']]
  end

  private

    def set_pubdate
      if new_record?
        self.pubdate ||= DateTime.now
        self.status ||= 'P'
      end
    end

    def create_gravatar_url
      if (not self.gravatar or self.gravatar=='')
        gravatar_id = Digest::MD5::hexdigest(self.email).downcase
        self.gravatar = "http://gravatar.com/avatar/#{gravatar_id}?s=100&d=wavatar"
      end
    end
end
