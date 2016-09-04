class ShoppingCartsController < ApplicationController
  before_filter :authenticate_user!
  before_action :extract_shopping_cart, only: [:remove_item, :add_item, :save_list]
  before_action :find_item, only: [:remove_item]
  #mejorar este codigo

  def index
    t = Time.now.in_time_zone('Caracas')
    @user = current_user
    @shopping_carts = @user.shopping_carts.where("status_cart > :start_statuscart AND status_cart <= :end_statuscart AND shopping_carts.received_at < :dates", {start_statuscart: StatusCart::INICIADO, end_statuscart: StatusCart::PREPARADO, dates: t.strftime("%Y-%m-%d 16:30:00")}).order(id: :desc)
    @shopping_cart = @shopping_carts.first
  end

  def show
    t = Time.now.in_time_zone('Caracas')
    @user = current_user
    @shopping_carts = @user.shopping_carts.where("status_cart > :start_statuscart AND status_cart <= :end_statuscart AND shopping_carts.received_at < :dates", {start_statuscart: StatusCart::INICIADO, end_statuscart: StatusCart::PREPARADO, dates: t.strftime("%Y-%m-%d 16:30:00")}).order(id: :desc)
    @shopping_cart = @shopping_carts.find(params[:id])
  end
  
  def for_tomorrow
    t = Time.now.in_time_zone('Caracas')
    @user = current_user
    @shopping_carts = @user.shopping_carts.where("status_cart > :start_statuscart AND status_cart <= :end_statuscart AND shopping_carts.updated_at >= :dates", {start_statuscart: StatusCart::INICIADO, end_statuscart: StatusCart::RECIBIDO, dates: t.strftime("%Y-%m-%d 16:30:00")}).order(id: :desc)
    @shopping_cart = @shopping_carts.first
  end

  def show_for_tomorrow
    t = Time.now.in_time_zone('Caracas')
    @user = current_user
    @shopping_carts = @user.shopping_carts.where("status_cart > :start_statuscart AND status_cart <= :end_statuscart AND shopping_carts.updated_at >= :dates", {start_statuscart: StatusCart::INICIADO, end_statuscart: StatusCart::RECIBIDO, dates: t.strftime("%Y-%m-%d 16:30:00")}).order(id: :desc)
    @shopping_cart = @shopping_carts.find(params[:id])
  end

  def previous
    @user = current_user
    @shopping_carts = @user.shopping_carts.where("status_cart > ?", StatusCart::PREPARADO).order(id: :desc).limit(10)
    @shopping_cart = @shopping_carts.first
  end

  def show_previous
    @user = current_user
    @shopping_carts = @user.shopping_carts.where("status_cart > ?", StatusCart::PREPARADO).order(id: :desc).limit(10)
    @shopping_cart = @shopping_carts.find(params[:id])
  end

  def remove_item
    @shopping_cart.remove_item(@shopping_cart_item)
    render :status => 200, :json => {:shopping_cart => @shopping_cart}
  end

  def add_item
    a,b = @shopping_cart.validate_quantity(add_item_params)
    if a
      render :status => 200, :json => {:shopping_cart => @shopping_cart, :add => "true"}
    else
      render :status => 200, :json => {:shopping_cart => @shopping_cart, :add => "false", :reason => b}
    end
  end

  def save_list
    @shopping_cart.change_status_received(obs_params)
    render :status => 200, :json => {:shopping_cart => @shopping_cart}
  end

  private
    def extract_shopping_cart
      @shopping_cart = find_or_create_shopping_cart
    end

    def find_or_create_shopping_cart
      if find_shopping_cart.blank?
        current_user.shopping_carts.create
      else
        find_shopping_cart
      end
    end

    def find_shopping_cart
      ShoppingCart.find_by_id(params[:id])
    end

    def find_item
      @shopping_cart_item = ShoppingCartItem.find_by_id(params[:item_id])
    end

    def add_item_params
      params.permit(:product_id, :quantity, :amount)
    end

    def obs_params
      params.permit(:obs)
    end

end