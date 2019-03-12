Rails.application.routes.draw do
    namespace :api do
        namespace :v1 do
            namespace :admin do
                resources :users, shallow: true do
                    resources :mental_models, shallow: true do
                        resources :paragraphs, shallow: true do
                            resources :cards
                        end
                    end
                end
            end
            namespace :application do
                post '/login', to: 'action#login'
                post '/signup', to: 'action#signup'
                get '/refresh-store', to: 'action#refresh_store'
                post '/refresh-database', to: 'action#refresh_database'
            end
        end
    end

    get '/*a', to: 'application#not_found'
end
