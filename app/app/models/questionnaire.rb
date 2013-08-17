class Questionnaire < ActiveRecord::Base
  attr_accessible :description, :title
  attr_accessor :definition

  has_many :questionnaire_instances, dependent: :destroy

  def survey_path
    warn "[DEPRECATION] `survey_path` is deprecated. Please use `QuestionnaireServices.questionnaire_path` instead."
    QuestionnaireServices.path(self)
  end

  def to_text
    self.definition ||= File.read(QuestionnaireServices.path(self))
  end
end
