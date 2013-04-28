class AddBlankToPhrase < ActiveRecord::Migration
  def change
    add_column :phrases, :blank, :boolean
  end
end
