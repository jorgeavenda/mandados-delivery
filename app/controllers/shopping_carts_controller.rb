class ShoppingCartsController < ApplicationController
  before_action :extract_shopping_cart
  before_action :find_item, only: [:remove_item]

  def remove_item
    @shopping_cart.remove_item(@shopping_cart_item)
    render :status => 200, :json => {:shopping_cart => @shopping_cart}
  end

  def add_item
    @shopping_cart.add_item(add_item_params)
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
      @shopping_cart_item = ShoppingCartItem.where(id: params[:item_id])
    end

    def add_item_params
      params.permit(:product_id, :quantity, :amount)
    end

end
