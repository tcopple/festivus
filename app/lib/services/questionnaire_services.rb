module QuestionnaireServices
  def self.parse questionnaire
    #TODO add validation to make sure the survey has actually been updated before parsing
    Surveyor::Parser.parse_file(questionnaire.survey_path)
  end

  def self.path questionnaire
    filename = questionnaire.title.gsub(' ', '').underscore.gsub('_', '-')
    Rails.root.join('surveys', filename)
  end

  def self.get_surveyor_survey questionnaire
    Surveyor::Survey.where(access_code: questionnaire.title).order("survey_version DESC").first
  end

  def self.create_surveyor_instance questionnaire, questionnaire_instance
    #copied from surveyor create controller methods, but returns different info
    @survey = QuestionnaireServices.get_surveyor_survey(questionnaire)

    questionnaire_instance.surveyor_reponse_set = Surveyor::ResponseSet.create(survey: @survey, user_id: questionnaire_instance.user_id)
    return !questionnaire_instance.surveyor_response_set.nil?

    # if (@survey && @response_set)
    #   flash[:notice] = t('surveyor.survey_started_success')
    #   redirect_to(surveyor.edit_my_survey_path(:survey_code => @survey.access_code, :response_set_code  => @response_set.access_code))
    # else
    #   flash[:notice] = t('surveyor.Unable_to_find_that_survey')
    #   redirect_to surveyor_index
    # end
  end
end
