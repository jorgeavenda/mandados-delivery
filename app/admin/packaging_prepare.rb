ActiveAdmin.register ShoppingCart, as: "prepare_packaging" do
	menu false

  permit_params  :packings_attributes => [:id, :quantity, :packing_type, :_destroy]

  config.clear_action_items!
  
  actions :all, except: [:new, :destroy, :show, :index]

  action_item :atras, only: [:edit, :show] do
    link_to "Volver", admin_received_path(prepare_packaging)
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
    def update
      update! do |format|
        format.html { redirect_to admin_received_path(@prepare_packaging) }
      end
    end
  end

end