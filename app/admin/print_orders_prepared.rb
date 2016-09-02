ActiveAdmin.register_page "Print_orders_prepared" do
  menu false

  content :title => 'Mandados preparados' do
    render partial: 'print_orders_prepared'
  end

  page_action :index do
    @buyer_delivered = Buyer.select(:id).group(:id).joins(:shopping_carts).where('shopping_carts.status_cart > 3').map{|i| i.id}
    @shopping_carts_prepared = ShoppingCart.where(status_cart: StatusCart::PREPARADO)
    @shopping_carts = @shopping_carts_prepared.select(:buyer_id).group(:buyer_id)
    @config_system = ConfigSystem.last
  end

end