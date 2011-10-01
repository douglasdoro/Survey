class Question < ActiveRecord::Base

  belongs_to :survey
  has_many   :answers, :dependent => :destroy
  has_many   :choices, :dependent => :destroy
  
  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => lambda { |at| at[:content].blank? } 
  
  def already_responded?(user)
    (user.choices.map(&:answer_id) & self.answer_ids).any?
  end
  
  def total
    self.answers.map(&:choice_ids).flatten.compact.count
  end
  
end
