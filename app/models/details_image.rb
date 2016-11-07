class DetailsImage < ActiveRecord::Base

  belongs_to :event

  mount_uploader :photo, AvatarUploader

end
