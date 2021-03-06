Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :show]
      resources :quizzes,    only: [:index, :show]
      resources :questions,  only: [:index, :show]
      resources :results,    only: [:index] do
        delete :destroy, on: :collection
      end
      resources :answers,    only: [:create]
      resources :users,    only: [:index]

      namespace :users do
        post 'sign_in', to: 'authentications#create' 
        post 'sign_up', to: 'registrations#create' 
      end
    end
  end

  get '/:page', to: 'pages#index', constraints: { page: /.*/ }

  root 'pages#index'
end
