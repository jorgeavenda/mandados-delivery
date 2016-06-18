ActiveAdmin.register_page "Print_orders_prepared" do
  menu false

  content do
    render partial: 'print_orders_prepared'
  end

  page_action :index do
    @shopping_carts = ShoppingCart.select(:buyer_id).group(:buyer_id).where(status_cart: StatusCart::PREPARADO)
  end

end