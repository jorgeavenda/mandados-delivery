class MainController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @shopping_cart = @user.get_shopping_cart
    @products = Product.show_by_stock
  end

end
