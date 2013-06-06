class AddRecipeOrderToIngredients < ActiveRecord::Migration
  def up
    add_column :ingredients, :recipe_order, :integer
    Ingredient.all.each do |ingredient|
      ingredient.recipe_order = 0
      ingredient.save
    end
  end
  
  def down
    remove_column :ingredients, :recipe_order
  end
end
