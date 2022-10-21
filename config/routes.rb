Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
devise_for :admin,skip: [:registrations,:passwords], controllers: {
 sessions: "admin/sessions"
}

namespace :admin do
  root to: "homes#top"
  resources :customers, only: [:index, :show, :edit, :update]
  resources :reviews, only: [:index, :show, :destroy]
  resources :book_comments, only: [:index, :show, :destroy]
end

# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  #customers: "sessions#guest_sign_in"
}

#ゲストユーザー用
devise_scope :customer do
  post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
end

root to: "public/homes#top"
get "about" => "public/homes#about"
get "tops" => "public/homes#tops"
get "search" => "public/goods#search"
scope module: "public" do
  get "customers/:id/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
  patch "customers/:id/withdraw" => "customers#withdraw", as: "withdraw"
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
   resources :book_comments, only: [:index, :create, :destroy]
  end

  resources :tags, only: [:index, :show, :destroy]
  resources :customers, only: [:show, :edit, :update]
  resources :goods, only: [:index, :show] do
    collection do
      get 'search'
      get 'search_index_result'
      get 'search_top'
    end
    resources :reviews, only: [:index, :show, :create]
  end
 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
