class MainController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @shopping_cart = @user.get_shopping_cart
    @products = Product.show_by_stock
    @config_system = ConfigSystem.last
  end

  def commanded_detail
  	@user = current_user
  	@shopping_cart = @user.shopping_carts.last
  end

end
