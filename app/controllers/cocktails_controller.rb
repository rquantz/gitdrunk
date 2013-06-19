class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]

  # GET /cocktails
  def index
    authorize! :read, Cocktail
    @cocktails = Cocktail.order(:name).paginate(page: params[:page])
  end

  # GET /cocktails/1
  def show
    authorize! :read, Cocktail
  end

  # GET /cocktails/new
  def new
    authorize! :create, Cocktail
    @cocktail = Cocktail.new
  end

  # GET /cocktails/1/edit
  def edit
    authorize! :update, @cocktail
  end

  # POST /cocktails
  def create
    authorize! :create, Cocktail
    @cocktail = Cocktail.new(cocktail_params)

    if @cocktail.save
      redirect_to @cocktail, notice: 'Cocktail was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /cocktails/1
  def update
    authorize! :update, @cocktail
    if @cocktail.update(cocktail_params)
      redirect_to @cocktail, notice: 'Cocktail was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /cocktails/1
  def destroy
    authorize! :destroy, @cocktail
    @cocktail.destroy
    redirect_to cocktails_url, notice: 'Cocktail was successfully destroyed.'
  end
  
  def search
    authorize! :read, Cocktail
    @cocktails = Cocktail.search(params[:q])
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cocktail
      @cocktail = Cocktail.includes(:recipes).find(params[:id])
      @cocktail.recipes.each {|recipe| recipe.current_user = current_user}
    end

    # Only allow a trusted parameter "white list" through.
    def cocktail_params
      params[:cocktail].permit(:name, :description)
    end
end
