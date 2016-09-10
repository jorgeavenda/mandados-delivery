ActiveAdmin.register Zone do
  menu false
  permit_params :name, :city_id

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  form do |f|
    f.inputs "Zone" do
      f.input :name
      f.input :city, as: :select, collection: City.all, label: 'Ciudad'
    end
    f.actions
  end

end
