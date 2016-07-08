class HowToBuyController < ApplicationController
  def instructions
    @user = current_user
  end
  def condition
    @user = current_user
    @config_system = ConfigSystem.last
  end
end
