module QuestionnaireServices
  def self.parse questionnaire
    #TODO add validation to make sure the survey has actually been updated before parsing
    Surveyor::Parser.parse_file(questionnaire.survey_path)
  end

  def self.path questionnaire
    filename = questionnaire.title.gsub(' ', '').underscore.gsub('_', '-')
    Rails.root.join('surveys', filename)
  end
end
