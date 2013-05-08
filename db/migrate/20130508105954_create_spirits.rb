class CreateSpirits < ActiveRecord::Migration
  def change
    create_table :spirits do |t|
      t.string :name
      t.boolean :is_brand

      t.timestamps
    end
  end
end
