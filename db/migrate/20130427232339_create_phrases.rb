class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :content
      t.integer :hit_points

      t.timestamps
    end
  end
end
