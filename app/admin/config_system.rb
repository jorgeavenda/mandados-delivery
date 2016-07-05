ActiveAdmin.register ConfigSystem do
  menu parent: "Configuracion"
  permit_params :delivery_price, :min_total_cart, :min_quantity, :dispatch_margin_error

  index do
    id_column
    column :delivery_price
    column :min_total_cart
    column :min_quantity
    column :dispatch_margin_error
    actions
  end

  form do |f|
    f.inputs "Configuracion" do
      f.input :delivery_price
      f.input :min_total_cart
      f.input :min_quantity
      f.input :dispatch_margin_error
    end
    f.actions
  end

end