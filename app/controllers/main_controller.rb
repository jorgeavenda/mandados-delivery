class MainController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @products = Product.show_by_stock
  end

end
