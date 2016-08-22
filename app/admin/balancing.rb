ActiveAdmin.register_page "balancings" do
  menu parent: "Admin", label: "Balances"

  content :title => 'Balances' do
    render partial: 'balancings'
  end

  page_action :index do
    @balancing_of_account = BalancingOfAccount.last
    unless @balancing_of_account.blank?
      date_start = @balancing_of_account.end_at
    else
      date_start = ShoppingCart.where(status_cart: StatusCart::PREPARADO).order(prepared_at: :desc).last.prepared_at
    end
  end

  page_action :balancing do

  end

end