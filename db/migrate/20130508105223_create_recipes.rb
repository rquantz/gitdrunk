class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :cocktail_id
      t.text :tasting_notes

      t.timestamps
    end
  end
end
