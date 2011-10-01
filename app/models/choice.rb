# encoding: utf-8

class Choice < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :answer
  
  validates :user,   :presence => true
  validates :answer, :presence => true
  
  # validates_uniqueness_of :user_id, :scope => :answer_id , :message => "Voce já respondeu essa pergunta!" 
  validate :if_responded
   
  private
  
  def if_responded 
    if self.answer_id.present? and self.user_id.present?
      answer = Answer.find self.answer_id
      user = User.find self.user_id
    
      errors.add("choice", "Você já respondeu essa pergunta!") if answer.question.already_responded?(user)
    end
  end

end
