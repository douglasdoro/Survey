class User < ActiveRecord::Base
  
  has_many :surveys, :dependent => :destroy
  has_many :watches 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar

  mount_uploader :avatar, AvatarUploader
end
