class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :current_customer, only: [:edit, :update]
  before_action :ensure_guest_customer, only: [:edit]
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
    if @customer == current_customer
      render :edit
      flash[:notice] ="編集に成功しました。"
    else
      redirect_to customer_path(current_customer)
  end
  
  def create
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer = current_customer
    if @customer.update(customer_pramas)
      flash[:notice] = "更新に成功しました。"
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end
  
  private
  
  def customer_pramas
    params.require(:customer).permit()
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
