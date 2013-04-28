class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :keyword
      t.text :content
      t.integer :phrase_id

      t.timestamps
    end
  end
end
