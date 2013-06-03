class AddRecipeOrderToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :recipe_order, :integer
  end
end
