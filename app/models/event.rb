class Event < ActiveRecord::Base

  belongs_to :user

  has_many :attends
  has_many :favorites
  has_many :details_images, dependent: :destroy

  mount_uploader :image, SummaryImageUploader

  validates :end_date, presence: true
  validates :dest, presence: true
  validates :apply_end_date, presence: true
  validate  :apply_date_check
  validate  :apply_term_check
  validate  :start_end_term_check

  enum status: { open: 0, draft: 1 }

  # カスタムバリデーション
  # 申し込み開始日のチェック
  def apply_date_check
    if apply_start_date and end_date < apply_start_date
      errors.add(:apply_start_date, "can't be in the past than end_date")
    end
  end

  # applyのendがstartより後かどうか
  def apply_term_check
    if apply_start_date and apply_start_date > apply_end_date
      errors.add(:apply_end_date, "can't be in the past than apply_start_date")
    end
  end

  # endがstartより後かどうか
  def start_end_term_check
    if start_date and start_date > end_date
      errors.add(:end_date, "can't be in the past than start_date")
    end
  end

  # --- クエリ スコープ ---
  # title、summary、destカラムの部分検索
  scope :text_like, -> text {
    where('title like ? or summary like ? or dest like ?', "%#{text}%", "%#{text}%", "%#{text}%") if text.present?
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
