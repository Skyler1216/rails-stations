Rails.application.routes.draw do
  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # 映画一覧・詳細表示
  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show'

  # 公開ページの座席予約機能
  resources :movies, only: [:index, :show] do
    get 'reservation', on: :member  # /movies/:id/reservation

    resources :schedules, only: [] do
      resources :reservations, only: [:new]  # /movies/:movie_id/schedules/:schedule_id/reservations/new
    end
  end

  resources :reservations, only: [:create]  # POST /reservations

  # 座席一覧
  resources :sheets, only: [:index]

  # 管理画面
  namespace :admin do
    resources :movies, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      resources :schedules, only: [:new, :create]
    end
    resources :schedules, only: [:index, :show, :edit, :update, :destroy]
    resources :reservations, only: [:index, :new, :create, :show, :update, :destroy]
  end

  # root "posts#index"
end
