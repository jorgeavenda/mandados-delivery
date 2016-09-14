ActiveAdmin.register ShoppingCart, as: "received" do
	menu parent: "Mandados", label: "Recibidos", priority: 1

  permit_params do
    params = [:quantity]
  end

  @buyer_delivered = Buyer.select(:id).group(:id).joins(:shopping_carts).where("status_cart > :statuscart", {statuscart: StatusCart::ENVIADO}).map{|i| i.id}

  index :title => 'Mandados recibidos', :row_class => -> record { 'buyer_new' unless @buyer_delivered.include? record.buyer_id } do
    column ""
    column "Nro. Mandado", :id
    column "Cliente", :buyer_id
    column "Fecha de Recibido", :updated_at  do |obj|
      obj.updated_at.in_time_zone('Caracas').strftime("%d / %m / %Y")
    end

    #guardar en session url con parametros de filter
    session.delete(:admin_url_received)
    session[:admin_url_received] ||= request.fullpath

    actions defaults: false do |received|
      link_to 'Preparar', admin_received_path(received)
    end
  end
    
    config.clear_action_items!
    config.sort_order = 'id_asc'
    #config.remove_action_item(:new)
    
    actions :all, except: [:new, :destroy]
    filter :get_zone_in, as: :select, collection: Zone.all.map {|r| [r.get_zone_full, r.id]}, label: 'Zona'
    # before_filter :skip_sidebar!, :only => :index


  show :title =>  proc{|s| "Mandado: #{s.id}" } do
    render partial: 'show'
  end

  action_item :atras, only: :show do
    # link_to "Volver", admin_receiveds_path
    link_to "volver", session[:admin_url_received]
  end

  action_item :usuario, only: :show do
    link_to "Usuario", admin_buyer_path(received.buyer_id, shopping_cart: received.id)
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
      @buyer_delivered = Buyer.select(:id).group(:id).joins(:shopping_carts).where("status_cart > :statuscart", {statuscart: StatusCart::ENVIADO}).map{|i| i.id}
      t = Time.now.in_time_zone('Caracas')
      super.where("status_cart = :statuscart AND updated_at < :dates", {statuscart: StatusCart::RECIBIDO, dates: t.strftime("%Y-%m-%d 16:30:00")})
    end

    def show
      buyer_id = ShoppingCart.find(params[:id]).buyer_id
      @statuscart = Buyer.find(buyer_id).shopping_carts.select(:status_cart).order(:status_cart).last
      @param_zone = session[:admin_url_received]
      super
    end
  end

end