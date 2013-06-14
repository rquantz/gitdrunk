class IngredientsController < ApplicationController
  respond_to :json

  def create
    @ingredient = Ingredient.new(ingredient_params)
    authorize! :create, @ingredient
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

  def destroy
    @ingredient = Ingredient.find(params[:id])
    respond_with @ingredient.destroy
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:spirit_id, :recipe_id, :amount, :recipe_order)
    end
end
