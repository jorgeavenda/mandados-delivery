ActiveAdmin.register MediaFile do
  menu parent: "Configuracion"
  permit_params :name, :description, :media_type, :media

  index do
    selectable_column
    id_column
    column :name
    column :description
    column('Tipo de Multimedia') { |s| MediaType.key_for(s.media_type).to_s.humanize }
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Product Details"  do
      f.input :name
      f.input :description
      f.input :media_type, as: :select, collection: MediaType.to_a, label: 'Tipo de Multimedia'
      f.input :media, :as => :file
    end
    f.actions
  end

end
