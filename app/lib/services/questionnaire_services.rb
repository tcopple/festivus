module QuestionnaireServices
  def self.parse_questionnaire questionnaire
    #TODO add validation to make sure the survey has actually been updated before parsing
    Surveyor::Parser.parse_file(questionnaire.survey_path)
  end
end
