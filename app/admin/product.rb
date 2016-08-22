ActiveAdmin.register Product do
  menu parent: "Productos"
  permit_params :description, :cost, :price, :image, :stock, :stock_min, :stock_max, :measuring_type, :active, :imageproduct, product_images_attributes: [:id, :image, :_destroy]

  index do
    selectable_column
    id_column
    column :description
    column :cost
    column :price
    column :stock
    column :stock_min
    column :stock_max
    column('Tipo de Medida') { |s| MeasuringType.key_for(s.measuring_type).to_s.humanize }
    column :active
    column :created_at
    column :updated_at
    actions
  end

  filter :stock
  filter :stock_min
  filter :stock_max
  filter :measuring_type
  filter :active

  show do |aboutblogger|
    attributes_table do
      rows :id, :description, :price, :stock, :stock_min, :stock_max
      row('Tipo de Medida') { |b| MeasuringType.key_for(b.measuring_type).to_s.humanize }
      rows :active, :created_at, :updated_at
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Product Details"  do
      f.input :description
      f.input :cost
      f.input :price
      f.input :stock
      f.input :stock_min
      f.input :stock_max
      f.input :measuring_type, as: :select, collection: MeasuringType.to_a, label: 'Tipo de Medida'
      f.input :active
      f.input :imageproduct, :as => :file
    end
    # f.has_many :product_images do |i|
    #   i.input :image, :as => :file, :hint => i.object.image.present? ? image_tag(i.object.image.url(:thumb)) : content_tag(:span, "Ninguna imagen aun")
    #   i.input :image_cache, :as => :hidden
    #   i.input :_destroy, :as => :boolean, :required => false, :label => 'Remove'
    # end
    f.actions
  end

end
