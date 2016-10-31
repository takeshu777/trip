class Event < ActiveRecord::Base

  belongs_to :user

  has_many :attends

  mount_uploader :image, AvatarUploader

  validates :title, presence: true

  enum status: { open: 0, draft: 1 }

end
