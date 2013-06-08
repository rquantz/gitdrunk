class BarsController < ApplicationController
  def show
    @bar = current_user.bar
  end
end
