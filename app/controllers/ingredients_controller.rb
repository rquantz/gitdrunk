class IngredientsController < ApplicationController
  respond_to :json

  def create
    @ingredient = Ingredient.create(ingredient_params)
    respond_with @ingredient
  end
  
  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      render json: {}.to_json, status: :ok
    else
      render json: @ingredient.to_json, status: :unprocessable_entity
    end
  end
  
  private
    def ingredient_params
      params.require(:ingredient).permit(:spirit_id, :recipe_id, :amount)
    end
end