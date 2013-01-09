FlagApp::Application.routes.draw do

  match 'announcements/:id/hide', as: 'hide_announcement', to: 'announcements#hide'
  match 'signup', to: "users#new"
  match 'login', to: "sessions#new"
  match 'logout', to: "sessions#destroy"
  match 'profile', to: "users#show"
  match 'about', to: "static_pages#about"
  match 'users/:id/scrapbook/day', as:'day', to: "scrapbooks#day"
  match 'users/:id/scrapbook/week', as:'week', to: "scrapbooks#week"
  match 'users/:id/scrapbook/month', as:'month', to: "scrapbooks#month"
  match 'users/:id/scrapbook/year', as:'year', to: "scrapbooks#year"
  match 'weekly_scrapbook', to: "static_pages#weekly"
  match 'monthly_scrapbook', to: "static_pages#monthly"
  match 'yearly_scrapbook', to: "static_pages#yearly"
  match "users/:id/images/:id/resize", to: "images#resize"
  match "users/:id/images/:id/drag", to: "images#drag"
  match "users/:id/images/:id/update", to: "images#update"
  match "users/:id/images/:id/edit", to: "images#edit"
  match "users/:id/update", to: "users#update"
  match "users/create", to: "users#create", as: "create_guest"

  resources :users do 
  	resources :images
    resources :journals
    resources :scrapbooks
  end 
   
  resources :sessions
  resources :announcements
  resources :password_resets
  

  
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
   root :to => 'static_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
