class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: {greater_than: 0}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> {where(is_hidden: false)}
  scope :recent, -> { order('created_at DESC')}

  has_many :resumes

  def present?
    is_present
  end

  has_many :job_relationships
  has_many :members, through: :job_relationships, source: :user

  belongs_to :user
  has_many :favorites
  has_many :fans, through: :favorites, source: :user

end
