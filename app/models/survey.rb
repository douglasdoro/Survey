class Survey < ActiveRecord::Base
  
  belongs_to :user
  has_many   :questions, :dependent => :destroy
  
  has_many :watches
  has_many :users, :through => :watches
  
  accepts_nested_attributes_for :questions, :allow_destroy => true
  
  validates :name, :presence => true
  validates :user, :presence => true
  
  scope :published, where(:published => true)

  def self.watching(user)
    includes(:questions).where(:id => user.watches).published
  end
  
  def self.my(user)
    user.surveys.includes(:questions)
  end
end
