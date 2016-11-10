class Place < ActiveRecord::Base

	# 検索用スコープの定義
  scope :name_reading_like, -> text {
    where('name like ? or reading like ?', "#{text}%", "#{text}%") if text.present?
  }

end
