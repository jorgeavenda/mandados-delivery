class HowToBuyController < ApplicationController
  before_filter :authenticate_user!, only: [:condition]
  
  def instructions
    @user = current_user
  end
  def condition
    @user = current_user
    @config_system = ConfigSystem.last
  end
end
