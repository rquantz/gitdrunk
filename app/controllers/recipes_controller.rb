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
    authenticate_user!
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.current_user = current_user
    authorize! :create, @recipe
    @recipe.save
    respond_with @recipe
  end

  # PATCH/PUT /recipes/1
  def update
    authorize! :update, @recipe
    @recipe.update(recipe_params)
    render json: @recipe.to_json
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    render json: {}.to_json, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.includes(ingredients: [:spirit]).find(params[:id])
      @recipe.current_user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params[:recipe].permit(:tasting_notes, :cocktail_id, :instructions)
    end
end
