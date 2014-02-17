class CreateQuestionnaireInstances < ActiveRecord::Migration
  def change
    create_table :questionnaire_instances do |t|
      t.datetime :due_date
      t.integer :notification_count

      t.integer :questionnaire_id
      t.integer :contact_id
      t.integer :event_id

      t.integer :user_id

      t.integer :response_set_id

      t.timestamps
    end
  end
end
