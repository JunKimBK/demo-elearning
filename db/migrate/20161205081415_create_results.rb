class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :lesson_id
      t.integer :word_id
      t.boolean :is_correct
      t.integer :meaning_id
      t.references :lesson, foreign_key: true
      t.references :word, foreign_key: true
      t.references :meaning, foreign_key: true

      t.timestamps
    end
  end
end
