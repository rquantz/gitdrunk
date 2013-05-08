class AddAncestryToSpirits < ActiveRecord::Migration
  def change
    add_column :spirits, :ancestry, :string
    add_index :spirits, :ancestry
  end
end
