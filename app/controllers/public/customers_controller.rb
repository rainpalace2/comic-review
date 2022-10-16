class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  # before_action :ensure_guest_customer, only: [:edit]

  def new
    @book = Book.new
  end

  def show
    @customer = Customer.find(params[:id])
    @book = Book.new
    @book_comment = BookComment.new
    @books = @customer.books.all.order(params[:sort])
    @books = @books.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :profile_image, :is_deleted)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
     unless @customer == current_customer
      redirect_to customer_path(current_customer)
     end
  end


  # def ensure_guest_customer
  #   @customer = Customer.find(params[:id])
  #   if @customer.full_name == "guestuser"
  #     redirect_to customer_path(current_customer), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
  #   end
  # end

end
