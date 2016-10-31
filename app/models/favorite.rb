class Favorite < ActiveRecord::Base

  belongs_to :event
  belongs_to :user, :counter_cache => true

end
