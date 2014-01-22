class QuestionnaireInstance < ActiveRecord::Base
  attr_accessible :due_date, :email, :name, :notification_count

  belongs_to :questionnaire
  belongs_to :response_set

  after_initialize :constructor

  #"constructor" is a mnemonic to represent what I'd use in other languages.
  def constructor
    return if !new_record?
    self.notification_count ||= 0 if self.has_attribute? :notification_count
  end

  def overdue?
    Time.now > self.due_date
  end

  #not collision safe, just a stop gap for time being
  def user_id
    #takes the ascii ord of each character weights it by position in string and sums them together
    self.email.each_char.each_with_index.inject(0){|sum, c| c.first.ord * c.last}
  end

  def access_code
    rs = self.response_set
    surveyor.view_my_survey_path(response_set_code: rs.access_code, survey_code: rs.survey.access_code)
  end
end
