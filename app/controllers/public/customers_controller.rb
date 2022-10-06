class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]
  
  def show
  end
  
  def edit
  end
  
  def update
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
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
