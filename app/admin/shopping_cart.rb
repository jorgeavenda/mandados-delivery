ActiveAdmin.register ShoppingCart do
	menu parent: "Preparar pedidos"

  permit_params do
    params = [:quantity]
  end

  index :title => 'Mandados recibidos' do
    column "Nro. Mandado", :id
    column "Cliente", :buyer_id
    column "Fecha de Recibido", :updated_at  do |obj|
      obj.updated_at.strftime("%d / %m / %Y")
    end
    actions
  end
    
    config.clear_action_items! 
    #config.remove_action_item(:new)
    
    actions :all, except: [:edit, :destroy]
    before_filter :skip_sidebar!, :only => :index


  show :title =>  proc{|s| "Mandado: #{s.id}" } do
    render partial: 'show'
  end

  member_action :dispatched, method: :post do
    @shopping_cart = ShoppingCart.find(params[:id])
    @shopping_cart.shopping_cart_items.find(params[:item_id]).update_dispatched(params)
    render :layout => false, :status => 200
  end

  controller do
    def scoped_collection
      super.where(status_cart: StatusCart::RECIBIDO)
    end
  end

end