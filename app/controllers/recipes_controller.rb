class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]
  respond_to :json

  # GET /recipes
  def index
    respond_with @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
    respond_with @recipe
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    respond_with @recipe
  end

  # PATCH/PUT /recipes/1
  def update
    @recipe.update(recipe_params)
    puts @recipe.to_json
    render json: @recipe.to_json
  end

  # DELETE /recipes/1
  def destroy
    respond_with @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params[:recipe].permit(:tasting_notes, :cocktail_id)
    end
end
