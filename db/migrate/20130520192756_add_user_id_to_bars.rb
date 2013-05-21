class AddUserIdToBars < ActiveRecord::Migration
  def change
    add_column :bars, :user_id, :integer
    add_index :bars, :user_id
  end
end
