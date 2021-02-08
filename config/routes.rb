Rails.application.routes.draw do
  resources :events
  root 'events#index'
  get '/status', to: 'status#index'
  get '/user', to: 'status#user'
  scope '/auth' do
    post '/sign-up', to: 'users#create'
    post '/sign-in', to: 'user_token#create'
  end
  scope '/memories' do
    post '/url', to: 'memories#presigned_url'
    get '/geturl', to: 'memories#get_object_url'
    post '/new', to: 'memories#create'
    get '/all', to: 'memories#index'
    delete '/:id', to: 'memories#destroy'
  end
end
