class Questionnaire < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :questionnaire_instances, dependent: :destroy

  def survey_path
    filename = title.gsub(' ', '').underscore.gsub('_', '-')
    Rails.root.join('surveys', filename)
  end
end
