class Question < ActiveRecord::Base

  belongs_to :survey
  has_many   :answers, :dependent => :destroy
  has_many   :choices, :dependent => :destroy
  
  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => lambda { |at| at[:content].blank? } 
  
end
