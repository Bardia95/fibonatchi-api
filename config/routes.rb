Rails.application.routes.draw do
  resources :users, param: :_username do
    resources :mental_models
  end

  post 'auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
