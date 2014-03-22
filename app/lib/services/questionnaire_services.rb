require 'surveyor'

module QuestionnaireServices
  def self.parse questionnaire
    #TODO add validation to make sure the survey has actually been updated before parsing
    Surveyor::Parser.parse_file(questionnaire.survey_path)
  end

  def self.path questionnaire
    filename = questionnaire.title.gsub(' ', '').underscore.gsub('_', '-')
    Rails.root.join('surveys', filename)
  end

  def self.survey_from_questionnaire questionnaire
    access_code = QuestionnaireServices.normalize_title(questionnaire)
    Survey.where(access_code: access_code).order("survey_version desc").first
  end

  def self.create_surveyor_instance questionnaire, questionnaire_instance
    #copied from surveyor create controller methods, but returns different info
    @survey = QuestionnaireServices.survey_from_questionnaire(questionnaire)
    @user_id = questionnaire_instance.contact.id

    return ResponseSet.create(survey: @survey, user_id: @user_id)
  end

  def self.survey_exists? questionnaire
    File.exists? QuestionnaireServices.path(questionnaire)
  end

  def self.to_text questionnaire
    QuestionnaireServices.survey_exists?(questionnaire)\
      ? File.read(QuestionnaireServices.path(questionnaire))\
      : "Questionnaire file is not available and cannot be parsed."
  end

  def self.normalize_title questionnaire
    questionnaire.title.to_s.downcase.gsub(/[^a-z0-9]/,"-").gsub(/-+/,"-").gsub(/-$|^-/,"")
  end
end
