class MainController < ApplicationController
  before_filter :authenticate_user!
  before_action :check_active, only: [:index]

  def index
    @user = current_user
    @shopping_cart = @user.get_shopping_cart
    @products = Product.show_by_stock
    @config_system = ConfigSystem.last
    @media_banner = MediaFile.where("media_type = ?", MediaType::BANNER)
  end

  def check_active
    @user = current_user
    redirect_to action: :no_active unless @user.active
  end

  def no_active
    @user = current_user
  end

  def commanded_detail
  	@user = current_user
  	@shopping_cart = @user.shopping_carts.last
  end

end
