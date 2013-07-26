class QuestionnaireInstance < ActiveRecord::Base
  attr_accessible :due_date, :email, :name, :notification_count
  belongs_to :questionnaire

  def overdue?
    Time.now > self.due_date
  end
end
