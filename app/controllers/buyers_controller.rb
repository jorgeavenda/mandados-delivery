class BuyersController < ApplicationController
  

  def new
    @buyer = Buyer.new
    @buyer.build_buyer_info
    @buyer.build_domicile
    # @routes = DeliveryRoute.all
    @routes = DeliveryRoute.all
  end

  def create
    @buyer = Buyer.new(buyer_params)
    if @buyer.save
      render 'welcome', buyer: @buyer
      ActionCorreo.new_registered_user(@buyer).deliver
    else
      redirect_to new_buyer_path
    end
    
  end

  private

  def buyer_params
    params.require(:buyer).permit(:email, :password, :password_confirmation, :active, buyer_info_attributes: [:id, :buyer_id, :first_name, :last_name, :phonenumber], domicile_attributes: [:id, :buyer_id, :delivery_route_id, :home])
  end

end
