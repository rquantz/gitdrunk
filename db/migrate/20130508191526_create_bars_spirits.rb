class CreateBarsSpirits < ActiveRecord::Migration
  def change
    create_table :bars_spirits do |t|
      t.integer :bar_id
      t.integer :spirit_id
    end
  end
end
