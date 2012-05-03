Beartracks::Application.routes.draw do
  get "clerk_verification/show"

  get "clerk_sessions/new"
  post "clerk_sessions/create"
  get "resident_sessions/new"
  post "resident_sessions/create"
  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  root :to => 'home#index'
  match 'packages/package_slips' => 'packages#package_slips'
  resources :packages
  resources :clerks
  resources :residents
  match 'clerk/login' => 'clerk_sessions#new'
  match 'clerk/logout' => 'clerk_sessions#destroy'
  match 'resident/login' => 'resident_sessions#new'
  match 'resident/logout' => 'resident_sessions#destroy'
  match 'packages/:id/toggle_pickup' => 'packages#toggle_pickup'
  match 'clerks/:id/toggle_admin_access' => 'clerks#toggle_admin_access'
  match 'clerks/:id/update_password' => 'clerks#update_password', :as => 'update_clerk_password'
  
  match 'clerk/home' => 'packages#index'
  
  
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
