class ChangeBarsSpiritsToBottles < ActiveRecord::Migration
  def change
    rename_table :bars_spirits, :bottles
  end
end
