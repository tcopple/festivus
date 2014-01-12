class QuestionnaireInstance < ActiveRecord::Base
  attr_accessible :due_date, :email, :name, :notification_count

  belongs_to :questionnaire
  belongs_to :response_set

  def overdue?
    Time.now > self.due_date
  end

  #not collision safe, just a stop gap for time being
  def user_id
    #takes the ascii ord of each character weights it by position in string and sums them together
    self.email.each_char.each_with_index.inject(0){|sum, c| c.first.ord * c.last}
  end
end
