class BottlesController < ApplicationController
  respond_to :json

  def create
    authorize! :create, Bottle
    @bottle = Bottle.create(bottle_params.merge(bar_id: current_user.bar.id))
    current_user.bar.save if @bottle.persisted?
    respond_with @bottle
  end
  
  def destroy
    @bottle = Bottle.find(params[:id])
    authorize! :destroy, @bottle
    current_user.bar.spirits.delete @bottle.spirit, @bottle.spirit.ancestors
    current_user.bar.save
    respond_with @bottle
  end
  
  private
    def bottle_params
      params.require(:bottle).permit(:spirit_id)
    end
end
