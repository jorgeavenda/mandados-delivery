ActiveAdmin.register ShoppingCart, as: "packings" do
	menu parent: "Gestion de Mandados", label: "Empaques"

  permit_params  :packings_attributes => [:id, :quantity, :packing_type, :_destroy]

  index :title => 'Empaques' do
    column :id
    column :buyer_id
    column('Empaques') { |s| StatusCart.key_for(s.status_cart).to_s.humanize }
    actions defaults: false do |shopping_cart|
      link_to "Empaque", edit_admin_packing_path(shopping_cart)
    end
  end

  config.clear_action_items! 
  
  filter :id
  filter :buyer_id
  
  actions :all, except: [:new, :destroy]

  action_item :atras, only: [:edit, :show] do
    link_to "Volver", admin_packings_path
  end

  form :title => "Empaque" do |f|
    f.has_many :packings, heading: false, new_record: 'Añadir paquete' do |i|
      i.input :packing_type, as: :select, collection: PackingType.to_a, label: 'Tipo de Empaque'
      i.input :quantity, label: 'Cantidad'
      i.input :_destroy, :as => :boolean, :required => false, :label => 'Remover'
    end
    actions do
      f.action :submit, label: 'Guardar'
    end
  end

  controller do
    def scoped_collection
      super.where(status_cart: StatusCart::PREPARADO)
    end
  end

end