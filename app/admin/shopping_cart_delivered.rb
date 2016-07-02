ActiveAdmin.register ShoppingCart, as: "delivered" do
	menu parent: "Mandados", label: "Entregas del dia"


  index :title => 'Mandados enviados' do
    selectable_column
    column "Nro. Mandado", :id
    column "Cod. Cliente", :buyer_id
    column ("Cliente") { |s| (s.buyer.buyer_info.fullname).humanize }
    column "Fecha de entrega", :updated_at  do |obj|
      obj.updated_at.in_time_zone('Caracas').strftime("%d / %m / %Y")
    end
  end

  filter :buyer_id, label: "Cod. Cliente"
  filter :buyer_buyer_info_last_name_or_buyer_buyer_info_first_name, :as => :string, label: "Cliente"
  config.clear_action_items!

  batch_action :destroy, false
  batch_action "Entregar", confirm: "Marcar como entregado" do |ids|
    ShoppingCart.find(ids).each do |shopping_cart|
      shopping_cart.change_status_delivered
    end
    redirect_to collection_path, alert: "Listo"
  end

  controller do
    def scoped_collection
      super.where(status_cart: StatusCart::PREPARADO)
    end
  end

end