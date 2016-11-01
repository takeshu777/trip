class Event < ActiveRecord::Base

  belongs_to :user

  has_many :attends
  has_many :favorites

  mount_uploader :image, AvatarUploader

  validates :title, presence: true

  enum status: { open: 0, draft: 1 }

  # titleとsummaryカラムの部分検索
  scope :text_like, -> text {
    where('title like ? or summary like ?', "%#{text}%", "%#{text}%") if text.present?
  }

  # 開催日の検索
  scope :date_between, -> from, to {
    if from.present? && to.present?
      where(start_date: from..to)
    elsif from.present?
      where('start_date >= ?', from)
    elsif to.present?
      where('start_date <= ?', to)
    end
  }

end
