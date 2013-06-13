class BarsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @bar = current_user.bar
  end
end
