Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'merchants#index'

  get '/merchants', to: 'merchants#index', as: :merchants
  get '/merchants/new', to: 'merchants#new', as: :new_merchant
  get '/merchants/:id', to: 'merchants#show', as: :merchant
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit', as: :edit_merchant
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  get '/items', to: 'items#index', as: :items
  get '/merchants/:merchant_id/items', to: 'items#index', as: :merchant_items
  get '/items/:id', to: 'items#show', as: :item
  get '/merchants/:merchant_id/items/new', to: 'items#new', as: :new_item
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/items/:id/edit', to: 'items#edit', as: :edit_item
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy', as: :delete_item

  get '/cart', to: 'carts#index', as: :cart
  patch '/cart/:item_id', to: 'carts#add_item', as: :add_to_cart
  patch '/cart/:item_id/delete', to: 'carts#remove_item', as: :remove_from_cart
  patch '/cart/:item_id/add', to: 'carts#incr_qty', as: :incr_qty
  patch '/cart/:item_id/minus', to: 'carts#decr_qty', as: :decr_qty
  delete '/cart', to: 'carts#destroy', as: :empty_cart

  # get '/orders', to: 'orders#index', as: :orders
  get '/orders/new', to: 'orders#new', as: :new_order
  get '/orders/:id', to: 'orders#show', as: :order
  post '/orders', to: 'orders#create'


  get '/items/:item_id/reviews/new', to: 'reviews#new', as: :new_review
  post '/items/:item_id/reviews', to: 'reviews#create', as: :review
  get '/items/:item_id/reviews/:id/edit', to: 'reviews#edit', as: :edit_review
  patch '/items/:item_id/reviews/:id', to: 'reviews#update', as: :update_review
  delete '/items/:item_id/reviews/:id', to: 'reviews#destroy', as: :delete_review
end
