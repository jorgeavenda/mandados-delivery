class MainController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    session[:shopping_cart] = @user.get_shopping_cart
    @shopping_cart = session[:shopping_cart]
    @products = Product.show_by_stock
  end

end
