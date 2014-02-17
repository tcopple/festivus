class CreateQuestionnaireInstances < ActiveRecord::Migration
  def change
    create_table :questionnaire_instances do |t|
      t.datetime :due_date, null: false
      t.integer :notification_count

      t.integer :questionnaire_id, null: false
      t.integer :contact_id, null: false
      t.integer :event_id, null: false
      t.integer :user_id, null: false
      t.integer :response_set_id, null: false

      t.timestamps
    end
  end
end
