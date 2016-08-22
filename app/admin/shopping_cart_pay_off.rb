ActiveAdmin.register ShoppingCart, as: "pay_off" do
  menu parent: "cuadre", label: "Cuadre", priority: 16

  index :title => 'Mandados pendientes por cuadrar' do
    column "Nro. Mandado", :id
    column "Fecha de preparado", :updated_at  do |obj|
      obj.prepared_at.in_time_zone('Caracas').strftime("%d / %m / %Y")
    end
    column "Fecha de entregado", :updated_at  do |obj|
      unless obj.delivered_at.nil?
        obj.delivered_at.in_time_zone('Caracas').strftime("%d / %m / %Y")
      else
        'nil'
      end
    end
    column ('Estatus') { |s| StatusCart.key_for(s.status_cart).to_s.humanize }
    column ("Monto Total") { |s| number_to_currency(s.amount_total_cart, unit: '', separator: ',', delimiter: '.') }
    column ("Costo Total") { |s| s.cost_total_cart }
    actions
    panel "", :id => "foo-panel" do
      render :partial => "foo"
    end
  end

  filter :prepared_at

  config.clear_action_items!
  actions :all, except: [:edit, :destroy]

  show :title =>  proc{|s| "Mandado: #{s.id}" } do |shopping_cart|
    panel "Productos", class: "panel_overflow" do
      table_for shopping_cart.shopping_cart_items do
        column ("Description") { |s| (s.product.description) }
        column "Pedido", :quantity
        column "Despachado", :dispatched
        column ("Monto") { |s| number_to_currency(s.quantity*s.amount, unit: '', separator: ',', delimiter: '.') }
      end
    end
  end

  controller do
    def scoped_collection

      @cuadre_last = Cuadre.last
      @cuadre_new = Cuadre.new
      unless @cuadre_last.blank?
        date_start = @cuadre_last.end_date_at
      else
        date_start = ShoppingCart.where(status_cart: StatusCart::PREPARADO).order(prepared_at: :desc).last.prepared_at
      end
      @cuadre_new.start_date_at = date_start
      if params[:q].nil?
        @cuadre_new.end_date_at = Time.now.midnight - 1.day
      else
        if params[:q][:prepared_at_lteq].nil?
          @cuadre_new.end_date_at = Time.now.midnight - 1.day
        else
          @cuadre_new.end_date_at = params[:q][:prepared_at_lteq]
        end
      end

      time_range = (date_start)..(Time.now.midnight - 1.day)
      super.where("status_cart > 2").where('prepared_at' => time_range)

    end

    def add_cuadre
      cuadre = Cuadre.new(start_date_at: params[:start_date_at], end_date_at: params[:end_date_at])
      if cuadre.save
        redirect_to admin_pay_offs_path
      else
        redirect_to admin_pay_offs_path
      end
    end
  end

end