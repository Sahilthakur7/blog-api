Rails.application.routes.draw do
    scope module: :v1, constraints: ApiVersion.new('v1',true) do
        resources :categories 
        resources :articles
    end

    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
end

