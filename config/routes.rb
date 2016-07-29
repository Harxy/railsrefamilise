Rails.application.routes.draw do

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get '/auth/logout' => "auth0#logout"
  resources :auth0
  resources :notes
  resources :history
  get '/notes/:id/seen' => 'notes#seen'
  get '/notes/:id/remove' => 'notes#delete_from_view'
  get '/notes/:id/delete_mem' => 'notes#destroy'
  get '/notes/:id/push_back' => 'notes#push_back'
  get '/notes/:id/push_back_more' => 'notes#push_back_more'
  get '/notes/:id/priority' => 'notes#change_priority'
  get '/' => "notes#index"
  get '/blog' => "blogs#index"
  get '/user_info/seen_it' => "user_info#seen_it"
  get '/user_info/dismissed_events' => "user_info#dismissed_events"
  get '/feedback' => "feedback#index"
  post '/feedback' => "feedback#create"
  get '/options' => "options#index"
  post '/options' => "options#edit"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
