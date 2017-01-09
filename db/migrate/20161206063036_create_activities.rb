class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :type
      t.integer :type_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
