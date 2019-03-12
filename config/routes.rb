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
                get '/hydrate-store', to: 'refresh#hydrate-store'
                post '/rehydrate-database', to: 'refresh#rehydrate_database'
                get '/refresh-models', to: 'refresh#refresh-models'
            end
            namespace :authentication do
                post '/login', to: 'authentication#login'
                post '/signup', to: 'authentication#signup'
            end
        end
    end

    get '/*a', to: 'application#not_found'
end
