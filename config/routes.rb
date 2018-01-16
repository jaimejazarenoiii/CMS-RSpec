Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users", sessions: 'users/sessions' }
  mount Sidekiq::Web => "/sidekiq" # monitoring console

  devise_scope :user do
    authenticated :user do
      resources :products
      resources :users
      resources :categories
    end

    unauthenticated :user do
      resources :products, only: [:index, :show]
      resources :users, only: [:index, :show]
      resource :user, only: [:edit] do
        collection do
          patch "update_details"
        end
      end
    end
  end
  root "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
