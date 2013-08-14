class Questionnaire < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :questionnaire_instances, dependent: :destroy

  def survey_path
    filename = title.gsub(' ', '').underscore.gsub('_', '-')
    Rails.root.join('surveys', filename)
  end

  def parse_survey
    survey = File.read(this.survey_path)
  end

  # whenever a survey is updated it shoudl be reparsed regarding the database.
#   def save
#     require 'surveyor'
#     Surveyor::Parser.parse_file(survey_path)
#   end
end
