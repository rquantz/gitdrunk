class SpiritsController < ApplicationController
  respond_to :html, :json
  
  def index
    @spirits = Spirit.all
    respond_with(@spirits)
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
  
  private
    def spirit_params
      params.require(:spirit).permit(:name, :parent_id, :is_brand)
    end
end
