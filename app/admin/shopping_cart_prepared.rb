ActiveAdmin.register ShoppingCart, as: "prepared" do
  menu parent: "Mandados", label: "Preparados", priority: 2


  index :title => 'Mandados preparados' do
    selectable_column
    column "Nro. Mandado", :id
    column "Cod. Cliente", :buyer_id
    column ("Cliente") { |s| (s.buyer.buyer_info.fullname).humanize }
    column "Fecha de preparado", :updated_at  do |obj|
      obj.updated_at.in_time_zone('Caracas').strftime("%d / %m / %Y")
    end
    actions
  end

  filter :buyer_id, label: "Cod. Cliente"
  filter :buyer_buyer_info_last_name_or_buyer_buyer_info_first_name, :as => :string, label: "Cliente"

  config.clear_action_items!
  actions :all, except: [:edit, :destroy]

  show :title =>  proc{|s| "Mandado: #{s.id}" } do |shopping_cart|
    panel "Productos", class: "panel_overflow" do
      table_for shopping_cart.shopping_cart_items do
        column ("Description") { |s| (s.product.description) }
        column "Pedido", :quantity
        column "Despachado", :dispatched
        column ("Monto") { |s| number_to_currency(s.quantity*s.amount, unit: '', separator: ',', delimiter: '.') }
      end
    end
  end

  action_item :atras, only: :show do
    link_to "Volver", admin_prepareds_path
  end

  sidebar "Inf. Mandando", only: [:show] do
    attributes_table do
      row("Cod. Cliente") { |s| (s.buyer_id) }
      row("Cliente") { |s| (s.buyer.buyer_info.fullname).humanize }
      row("Monto total") { |s| number_to_currency(s.amount_total_cart, unit: '', separator: ',', delimiter: '.') }
    end
  end

  sidebar "Empaques", only: [:show] do |r|
    table_for prepared.packings do
      column ("Tipo de empaque") { |s| (PackingType.key_for(s.packing_type).to_s.humanize) }
      column "Cantidad", :quantity
    end
    link_to "Modificar", edit_admin_prepared_packaging_path, class: 'button'
  end

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