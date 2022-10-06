Rails.application.routes.draw do

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



root to: "public/books#search"
get "about" => "public/homes#about"
get "search" => "public/books#search"
scope module: "public" do
  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :create]
  end
 end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
