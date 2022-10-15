class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  layout "admin_application"
  
  def top
    @customer = Customer.all.page(params[:page]).per(10)
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
end
