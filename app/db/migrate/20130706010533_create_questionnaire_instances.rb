class CreateQuestionnaireInstances < ActiveRecord::Migration
  def change
    create_table :questionnaire_instances do |t|
      t.string :name
      t.string :email
      t.datetime :due_date
      t.integer :notification_count
      t.integer :questionnaire_id

      t.timestamps
    end
  end
end
