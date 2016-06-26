ActiveAdmin.register DeliveryRoute do
  menu false
  permit_params :addres, :delivery_time, :urbanization_id, :residential_id, :building_id

  index do
    selectable_column
    id_column
    column :addres
    column :urbanization
    column :residential
    column :building
    column :delivery_time
    actions
  end

  form do |f|
    f.inputs "Addres" do
      f.input :addres
      f.input :delivery_time, :as => :time_picker
      f.input :urbanization, as: :select, collection: Urbanization.all, label: 'Urb.'
      f.input :residential, as: :select, collection: Residential.all, label: 'Conj. Residencial'
      f.input :building, as: :select, collection: Building.all, label: 'Edif.'
    end
    f.actions
  end

end