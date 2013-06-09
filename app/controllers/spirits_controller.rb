class SpiritsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json
  
  def index
    @spirits = Spirit.all
    respond_with(@spirits)
  end
  
  def show
    @spirit = Spirit.find(params[:id])
  end
  
  def new
    
  end

  def create
    @spirit = Spirit.new(spirit_params)
    respond_to do |format|
      if @spirit.save
        format.html { redirect_to spirits_url }
        format.json { render json: @spirit.to_json }
      else
        format.html { render :new }
        format.json { render json: @spirit.to_json }
      end
    end
  end

  def edit
    @spirit = Spirit.find(params[:id])
  end
  
  def update
    @spirit = Spirit.find(params[:id])
    @spirit.update_attributes(spirit_params)
    respond_to do |format|
      if @spirit.save
        format.html { redirect_to spirits_url }
        format.json { render json: @spirit.to_json }
      else
        format.html { render :edit }
        format.json { render json: @spirit.to_json }
      end
    end
  end
  
  def destroy
    @spirit = Spirit.find(params[:id])
    @spirit.destroy
    redirect_to spirits_url
  end
  
  def search
    puts params[:brand_only]
    if params[:brand_only] == "true"
      
      @spirits = Spirit.search params[:search], with: { is_brand: true }
    else
      @spirits = Spirit.search params[:search]
    end
    respond_with @spirits
  end

  private
    def spirit_params
      params.require(:spirit).permit(:name, :parent_id, :is_brand)
    end
end
