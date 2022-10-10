Rails.application.routes.draw do

  namespace :public do
    get 'book_comments/create'
    get 'book_comments/destroy'
  end
# 管理者用
# URL /admin/sign_in ...
devise_for :admin,skip: [:registrations,:passwords], controllers: {
 sessions: "admin/sessions"
}

namespace :admin do
  root to: "homes#top"
  resources :customers, only: [:index, :show, :edit, :update]
end


# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  customers: "sessions#guest_sign_in"
}

#ゲストユーザー用
devise_scope :customers do
  post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
end



root to: "public/goods#search"
get "about" => "public/homes#about"
get "search" => "public/goods#search"
scope module: "public" do
  get "customers/:id/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
  patch "customers/:id/withdraw" => "customers#withdraw", as: "withdraw"
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
   resources :book_comments, only: [:create, :destroy]
  end

  resources :customers, only: [:show, :edit, :update]
  resources :goods, only: [:index, :show] do
    resources :reviews, only: [:index, :show, :create]
  end
 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
