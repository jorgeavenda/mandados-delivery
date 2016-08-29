ActiveAdmin.register Product, as: "product_inventory" do
  menu parent: "Productos", label: "Inventario"

  permit_params do
    params = [:price, :stock, :cost]
  end

  index do

    table do
      tr do
        td render 'inventory'
      end
    end

  end

    config.clear_action_items!
    config.batch_actions = false
    filter :description
    # before_filter :skip_sidebar!, :only => :index

  member_action :inventorying, method: :post do
    @product = Product.find(params[:id]).inventorying(params)
    render :layout => false, :status => 200
  end

end
