Rails.application.routes.draw do
    resources :categories 
    resources :articles

    post 'auth/login', to: 'authenticaion#authenticate'
end

