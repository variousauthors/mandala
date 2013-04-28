class PhraseContentToText < ActiveRecord::Migration
  def up
    change_column :phrases, :content, :text, :limit => nil
  end

  def down
    change_column :phrases, :content, :string
  end
end
