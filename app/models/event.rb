class Event < ActiveRecord::Base

  belongs_to :user

  has_many :attends
  has_many :favorites
  has_many :details_images, dependent: :destroy

  mount_uploader :image, AvatarUploader

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

  # 申込み日のスタート日の検索
  scope :apply_start_date_between, -> from, to {
    if from.present? && to.present?
      where(apply_start_date: from..to)
    elsif from.present?
      where('apply_start_date >= ?', from)
    elsif to.present?
      where('apply_start_date <= ?', to)
    end
  }

  # 申込み日の終わりの検索
  scope :apply_end_date_between, -> from, to {
    if from.present? && to.present?
      where(apply_end_date: from..to)
    elsif from.present?
      where('apply_end_date >= ?', from)
    elsif to.present?
      where('apply_end_date <= ?', to)
    end
  }


end
