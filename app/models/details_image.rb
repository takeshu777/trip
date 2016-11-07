class DetailsImage < ActiveRecord::Base

  belongs_to :event

  mount_uploader :photo, DetailsImageUploader

  validates :photo, presence: true

end
