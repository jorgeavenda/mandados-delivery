ActiveAdmin.register Zone do
  menu false
  permit_params :name, :city_id, :delivery_time_attributes => [:id, :delivery_hours, :max_time_received, :_destroy]

  index do
    selectable_column
    id_column
    column ("zone") { |s| (s.get_zone_full) }
    actions
  end

  form do |f|
    f.inputs "Zone" do
      f.input :name
      f.input :city, as: :select, collection: City.all, label: 'Ciudad'
      f.has_many :delivery_time do |t|
        t.input :delivery_hours, :as => :time_picker
        t.input :max_time_received, :as => :time_picker
        t.input :_destroy, :as => :boolean, :required => false, :label => 'Remover'
      end
    end
    f.actions
  end

end
