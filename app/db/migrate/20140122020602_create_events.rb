class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :where
      t.text :description
      t.datetime :when

      t.timestamps
    end
  end
end
