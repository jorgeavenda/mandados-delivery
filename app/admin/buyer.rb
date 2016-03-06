ActiveAdmin.register Buyer do
  menu parent: "Users"
  permit_params :email, :password, :password_confirmation, :active, :buyer_info_attributes => [:id, :buyer_id, :first_name, :last_name, :phonenumber]

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
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Buyer Details" do
      f.input :email
      f.input :active
      f.input :password
      f.input :password_confirmation
      #f.inputs "Buyer Info", for: :buyer_info do |t|
      f.inputs "Buyer Info", for: [:buyer_info, (f.object.buyer_info || BuyerInfo.new)] do |t|
        t.input :id, as: :hidden
        t.input :buyer_id, as: :hidden
        t.input :first_name
        t.input :last_name
        t.input :phonenumber
      end
      #f.has_one :buyer_info, heading: 'Buyer Info', allow_destroy: true do |c|
      #  c.input :first_name
      #  c.input :last_name
      #  c.input :phonenumber
      #end
      #f.input :email, label: f.object.buyer_info
      #f.input :password, label: "#{f.object.buyer_info.inspect}"
=begin      
      f.inputs 'Buyer Info', for: [:buyer_info, (f.object.buyer_info || f.object.build_buyer_info)],
        id: 'buyer_id', class: 'inputs polyform' do |fc|
        fc.input :first_name
        fc.input :last_name
        fc.input :phonenumber
      end
=end      
    end
    f.actions
  end

end
