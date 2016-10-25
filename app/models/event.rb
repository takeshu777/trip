class Event < ActiveRecord::Base

  belongs_to :user

  mount_uploader :image, AvatarUploader

  enum status: { open: 0, draft: 1 }

end
