class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :where
      t.text :description
      t.datetime :when
      t.integer :user_id

      t.timestamps
    end
  end
end
