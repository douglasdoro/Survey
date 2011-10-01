class Answer < ActiveRecord::Base

  belongs_to :question
  has_many   :choices

  def percentage
    self.choices.empty? ? 0 : (self.choices.size.to_f / self.question.total.to_f * 100)
  end
  
end
