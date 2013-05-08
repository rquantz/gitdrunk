class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :recipe_id
      t.integer :spirit_id
      t.string :amount

      t.timestamps
    end
  end
end
