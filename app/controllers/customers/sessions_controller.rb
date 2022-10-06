class Customers::SessionsController < Devise::SessionsController
  
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to about_path, notice: 'guestuserでログインしました。'
  end
end