class CreateMeanings < ActiveRecord::Migration[5.0]
  def change
    create_table :meanings do |t|
      t.integer :word_id
      t.string :content
      t.boolean :is_correct
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
