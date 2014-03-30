class QuestionnaireInstanceMailer < ActionMailer::Base
  default from: "notifier@festivus.com"

  def reminder_email(questionnaire_instance)
    @email = questionnaire_instance.email
    @due_date = questionnaire_instance.due_date
    @name = questionnaire_instance.name

    @m = mail(to: @email, subject: "Festivus Questionnaire Reminder")
    unless logger.nil?
      logger.info @m
    end

    @m
  end
end
