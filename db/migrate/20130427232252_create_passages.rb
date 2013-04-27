class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
      t.string :title
      t.integer :damage
      t.integer :population

      t.timestamps
    end
  end
end
