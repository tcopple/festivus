require 'pp'

module QuestionnaireInstanceServices
  def self.send_reminder instance
    mail = QuestionnaireInstanceMailer.delay.reminder_email(instance)
    instance.notification_count += 1
    return instance.save
  end
end
