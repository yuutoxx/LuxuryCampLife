Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords] ,controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #ゲストログイン
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root :to => 'homes#top'
    get 'about' => 'homes#about'
    resource :map, only: [:show]
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    get 'posts/search' => 'posts#search'
    get 'search_tag' => 'posts#search_tag'
    resources :posts, only: [:create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root :to => 'homes#top'
    get 'customers/search' => 'customers#search'
    get 'posts/search' => 'posts#search'
    get 'search_tag' => 'posts#search_tag'
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
  end
end
