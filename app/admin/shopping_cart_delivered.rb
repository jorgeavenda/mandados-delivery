ActiveAdmin.register ShoppingCart, as: "delivered" do
	menu parent: "Gestion de Mandados", label: "Entregas", priority: 3

  index :title => 'Entrega de Mandados Despachados' do
    render partial: 'delivered'
  end
    
    actions :all, except: [:new, :destroy]
    filter :get_zone_in, as: :select, collection: Zone.all.map {|r| [r.get_zone_full, r.id]}, label: 'Zona'
    # before_filter :skip_sidebar!, :only => :index


  controller do
    def scoped_collection
      @zonas = Zone.all
      super.where(status_cart: StatusCart::ENVIADO)
    end

  end

end