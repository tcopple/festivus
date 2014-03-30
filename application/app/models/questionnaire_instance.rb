class QuestionnaireInstance < ActiveRecord::Base
  attr_accessible :due_date, :notification_count, :event_id, :questionnaire_id, :contact_id

  belongs_to :event
  belongs_to :questionnaire
  belongs_to :contact

  belongs_to :user
  belongs_to :response_set

  after_initialize :constructor

  #"constructor" is a mnemonic to represent what would be used in other languages
  def constructor
    return if !new_record?
    self.notification_count ||= 0 if self.has_attribute? :notification_count
  end

  def overdue?
    Time.now > self.due_date
  end

  #not collision safe, just a stop gap for time being
  def user_id
    self.user.id
  end

  def access_code
    rs = self.response_set
    surveyor.view_my_survey_path(response_set_code: rs.access_code, survey_code: rs.survey.access_code)
  end

  def complete?
    response_set.complete?
  end
end
