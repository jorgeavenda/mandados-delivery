ActiveAdmin.register Buyer do
  menu parent: "Users"
  permit_params :email, :password, :password_confirmation, :active, :buyer_info_attributes => [:id, :buyer_id, :first_name, :last_name, :phonenumber], :domicile_attributes => [:id, :buyer_id, :delivery_route_id, :home]

  index do
    selectable_column
    id_column
    column :buyer_info
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :active
    actions
  end

  filter :email
  filter :active

  config.action_items.delete_if { |item|
    item.display_on?(:show)
  }

  show :title =>  proc{|s| "Usuario: #{s.id}" } do
    attributes_table do
      row :id
      row ("Nombre y Apellido") { |s| (s.buyer_info.fullname) }
      row ("Telefono") { |s| (s.buyer_info.phonenumber) }
      row ("Ruta") { |s| (s.domicile.delivery_route.get_addres_full) }
      row ("Casa o Apartamento") { |s| (s.domicile.home) }
    end
  end

  action_item :atras, only: :show do
    unless params[:shopping_cart].nil?
      link_to "Volver", admin_received_path(params[:shopping_cart])
    else
      link_to "Volver", admin_buyers_path
    end
  end

  form do |f|
    f.inputs "Buyer Details" do
      f.input :email
      f.input :active
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.inputs "Buyer Info", for: [:buyer_info, (f.object.buyer_info || BuyerInfo.new)] do |t|
        t.input :id, as: :hidden
        t.input :buyer_id, as: :hidden
        t.input :first_name
        t.input :last_name
        t.input :phonenumber
      end
      f.inputs "Domicile", for: [:domicile, (f.object.domicile || Domicile.new)] do |u|
        u.input :id, as: :hidden
        u.input :buyer_id, as: :hidden
        u.input :delivery_route, as: :select, collection: DeliveryRoute.all.map {|r| [r.get_addres_full, r.id]}, label: 'Ruta'
        u.input :home
      end
    end
    f.actions
  end

end
