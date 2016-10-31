class Attend < ActiveRecord::Base

  belongs_to :event, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates :comment, presence: true

end
