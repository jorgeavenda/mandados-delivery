ActiveAdmin.register Postulation do
  menu false
  permit_params :email, :address, :comment, :status_postulation, :motive

  index do
    selectable_column
    id_column
    column :email
    column :address
    column :comment
    column('Estatus de postulacion') { |s| StatusPostulation.key_for(s.status_postulation).to_s.humanize }
    column :motive
    actions
  end

  form do |f|
    f.inputs "Postulation" do
      f.input :email
      f.input :address
      f.input :comment
      f.input :status_postulation, as: :select, collection: StatusPostulation.to_a, label: 'Estatus de postulacion'
      f.input :motive
    end
    f.actions
  end

end

