class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
  end
end
