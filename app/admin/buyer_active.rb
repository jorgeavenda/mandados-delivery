ActiveAdmin.register Buyer, as: "buyer_active" do
  menu parent: "Users", label: "Active"
  permit_params :email, :active, :buyer_info_attributes => [:id, :buyer_id, :first_name, :last_name, :phonenumber], :domicile_attributes => [:id, :buyer_id, :delivery_route_id, :home]
  
  index do
    column :email
  end

    config.clear_action_items!
    config.batch_actions = false

    before_filter :skip_sidebar!, :only => :index

  form do |f|
    f.inputs "Buyer Details" do
      f.input :email, :input_html => { :readonly => true }
      f.input :active
      f.inputs "Buyer Info", for: [:buyer_info, (f.object.buyer_info || BuyerInfo.new)] do |t|
        t.input :id, as: :hidden
        t.input :buyer_id, as: :hidden
        t.input :first_name, :input_html => { :readonly => true }
        t.input :last_name, :input_html => { :readonly => true }
        t.input :phonenumber, :input_html => { :readonly => true }
      end
      f.inputs "Domicile", for: [:domicile, (f.object.domicile || Domicile.new)] do |u|
        u.input :id, as: :hidden
        u.input :buyer_id, as: :hidden
        u.input :delivery_route, as: :select, collection: DeliveryRoute.all.map {|r| [r.get_addres_full, r.id]}, label: 'Ruta', :input_html => { :disabled => true }
        u.input :home, :input_html => { :readonly => true }
      end
    end
    f.actions
  end

end
