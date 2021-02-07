Rails.application.routes.draw do
  resources :events
  root 'events#index'
  get '/status', to: 'status#index'
  get '/user', to: 'status#user'
  scope '/auth' do
    post '/sign-up', to: 'users#create'
    post '/sign-in', to: 'user_token#create'
  end
end
