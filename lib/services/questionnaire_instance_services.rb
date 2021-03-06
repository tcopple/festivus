module QuestionnaireInstanceServices
  def self.send_reminder instance
    instance.notification_count += 1
    mail = QuestionnaireInstanceMailer.delay.reminder_email(instance)
    return instance.save
  end

  def self.get_surveyor_response_set questionnaire_instance
    survey = QuestionnaireServices.get_surveyor_survey(questionnaire_instance.questionnaire)
    Surveyor::ResponseSet.where(survey: survey, user_id: questionnaire_instance.user_id)
  end
end
