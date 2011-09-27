class Question < ActiveRecord::Base
  belongs_to :survey
  
  validates :content, :presence => true 
end
