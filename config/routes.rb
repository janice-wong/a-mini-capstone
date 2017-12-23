Rails.application.routes.draw do
  post '/users' => 'users#create'

  get '/products' => 'products#index'
  get '/products/:id' => 'products#show'
  post '/products' => 'products#create'
  patch '/products/:id' => 'products#update'
  delete '/products/:id' => 'products#destroy'

  get '/product_ids' => 'products#product_ids'
end
