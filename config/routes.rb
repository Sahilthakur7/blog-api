Rails.application.routes.draw do
    resources :categories 
    resources :articles

    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
end

