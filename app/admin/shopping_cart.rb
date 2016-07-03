ActiveAdmin.register ShoppingCart do
	menu parent: "Mandados", label: "Preparar", priority: 1

  permit_params do
    params = [:quantity]
  end

  index :title => 'Mandados para preparar' do
    column "Nro. Mandado", :id
    column "Cliente", :buyer_id
    column "Fecha de Recibido", :updated_at  do |obj|
      obj.updated_at.in_time_zone('Caracas').strftime("%d / %m / %Y")
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

  action_item :atras, only: :show do
    link_to "Volver", admin_shopping_carts_path
  end

  member_action :dispatched, method: :post do
    @shopping_cart = ShoppingCart.find(params[:id])
    @shopping_cart.shopping_cart_items.find(params[:item_id]).update_dispatched(params)
    render :layout => false, :status => 200
  end

  member_action :save_prepared, method: :post do
    
    @shopping_cart = ShoppingCart.find(params[:id])
    
    if @shopping_cart.shopping_cart_items.where("dispatched < quantity-0.02 OR dispatched > quantity+0.02").blank?
      @shopping_cart.change_status_prepared
      render :layout => false, :status => 200, :json => {:terminado => "true"} 
    else
     render :layout => false, :status => 200, :json => {:terminado => "false"}
    end
  end

  controller do
    def scoped_collection
      t = Time.now.in_time_zone('Caracas')
      super.where("status_cart = :statuscart AND updated_at < :dates", {statuscart: StatusCart::RECIBIDO, dates: t.strftime("%Y-%m-%d 16:30:00")})
    end
  end

end