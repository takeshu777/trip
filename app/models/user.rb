class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :f_name, presence: true
  validates :l_name, presence: true

  mount_uploader :avatar, AvatarUploader

  enum gender: { male: 0, female: 1 }

  has_many :events
  has_many :attends
  has_many :favorites

  def fullname
    return "#{f_name} #{l_name} "
  end

end
