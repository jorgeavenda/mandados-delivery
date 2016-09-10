ActiveAdmin.register DeliveryTime do
  menu false
  permit_params :delivery_hours, :max_time_received, :zone_id

  index do
    selectable_column
    id_column
    column :delivery_hours
    column :max_time_received
    column ("zone") { |s| (s.zone.get_zone_full) }
    actions
  end

  form do |f|
    f.inputs "DeliveryTime" do
      f.input :delivery_hours, :as => :time_picker
      f.input :max_time_received, :as => :time_picker
      f.input :zone, as: :select, collection: Zone.all.map {|r| [r.get_zone_full, r.id]}, label: 'Zona'
    end
    f.actions
  end

end
