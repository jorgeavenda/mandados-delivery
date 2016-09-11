class BuyersController < ApplicationController
  before_action :find_buyer, only: [:active, :edit_register, :update_register]

  def new
    @buyer = Buyer.new
    @buyer.build_buyer_info
    @buyer.build_domicile
    # @routes = DeliveryRoute.all
    @routes = DeliveryRoute.all
    @zone = Zone.all
  end

  def create
    @buyer = Buyer.new(buyer_params)
    if @buyer.save
      render 'welcome', buyer: @buyer
      ActionCorreo.new_registered_user(@buyer).deliver_now
    else
      @routes = DeliveryRoute.all
      @zone = Zone.all
      render 'new'
    end  
  end

  def edit_register
    @email = params[:email]
    @routes = DeliveryRoute.all
    unless @buyer.active
      if @buyer.email == @email
        render 'to_correct'
      end
    else
      redirect_to root_path
    end
  end

  def update_register
    if @buyer.update(buyer_params)
      redirect_to action: :msg_edit
      ActionCorreo.edit_registered_user(@buyer).deliver_now
    else
      @routes = DeliveryRoute.all
      render 'to_correct'
    end
  end

  def msg_edit
  end

  def active
    @email = params[:email]
    unless @buyer.active
      if @buyer.email == @email
        @buyer.activate
        render 'activated'
        #ActionCorreo.active_new_user(@buyer).deliver_now
      end
    else
      render 'activated'
    end
  end

  def zone_addres
    @addres = DeliveryRoute.where(zone: params[:zone]).order(:other)
    render :json => @addres, methods: [:get_without_addres, :get_addres_full, :get_delivery_time]
  end

  private

  def find_buyer
    @buyer = Buyer.find_by_id(params[:id])
  end

  def buyer_params
    params.require(:buyer).permit(:email, :password, :password_confirmation, :active, buyer_info_attributes: [:id, :buyer_id, :first_name, :last_name, :phonenumber], domicile_attributes: [:id, :buyer_id, :delivery_route_id, :home])
  end

end
