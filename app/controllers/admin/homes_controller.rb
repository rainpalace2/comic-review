class Admin::HomesController < ApplicationController
  
  def top
    @customer = Customer.all.page(params[:page]).per(10)
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
end
