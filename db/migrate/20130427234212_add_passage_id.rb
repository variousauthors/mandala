class AddPassageId < ActiveRecord::Migration
  def up
    add_column :phrases, :passage_id, :integer
    add_index :phrases, :passage_id
  end

  def down
    remove_column :phrases, :passage_id, :integer
  end
end
