FlagApp::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :users do 
    collection { post :sort }
    resources :images
    resources :journals
    resources :scrapbooks
  end 

  match 'signup', to: "users#new"
  match 'login', to: "sessions#new"
  match 'logout', to: "sessions#destroy"
  match 'profile', to: "users#show"
  match 'about', to: "static_pages#about"
  match 'dashboard', to: "static_pages#dashboard"
  match 'book', to: "static_pages#book"
  match 'users/:id/scrapbook/day', as:'day', to: "scrapbooks#day"
  match 'users/:id/scrapbook/week', as:'week', to: "scrapbooks#week"
  match 'users/:id/scrapbook/month', as:'month', to: "scrapbooks#month"
  match 'users/:id/scrapbook/year', as:'year', to: "scrapbooks#year"
  match 'weekly_scrapbook', to: "static_pages#weekly"
  match 'monthly_scrapbook', to: "static_pages#monthly"
  match 'yearly_scrapbook', to: "static_pages#yearly"
  match "users/:id/images/:id/resize", to: "images#resize"
  match "users/:id/images/:id/time_frame", to: "images#time_frame"
  match "users/:id/images/:id/z_index", to: "images#z_index"
  match "users/:id/images/:id/drag", to: "images#drag"
  match "users/:id/images/:id/update", to: "images#update"
  match "users/:id/images/:id/edit", to: "images#edit"
  match "users/:id/update", to: "users#update"
  match "users/create", to: "users#create", as: "create_guest"
  match "member_index", to: "users#member_index"

  match "announcement_partial", :to => "announcements#announcement_partial"
  
  match "event_partial", :to => "events#event_partial"
  match "image_partial", :to => "images#image_partial"
  match "coordinators", :to => "users#coordinators"

  resources :users do 
    collection { post :sort }
  	resources :images
    resources :journals
    resources :scrapbooks
  end 
  resources :partials

  # announcements
  match 'announcements/:id/hide', as: 'hide_announcement', to: 'announcements#hide'
  resources :announcements do
    collection { post :sort }
  end
  match "announcements/:id/announcement_status", to: "announcements#announcement_status", as: "announcement_status"
  match "announcements/:id/announcement_starts_at", to: "announcements#announcement_starts_at", as: "announcement_starts_at"
  match "announcements/:id/announcement_ends_at", to: "announcements#announcement_ends_at", as: "announcement_ends_at"
 
   
  # page
  resources :pages do
    collection { post :sort }
  end
  match 'pages/:id/status', to: 'pages#status', as: 'status'
  
  # announcements
  resources :announcements do 
    resources :statuses_statusables
  end
  
  # events
  resources :events do
    collection { post :sort }
  end
  match 'events/:id/event_status', to: 'events#event_status', as: 'event_status'
  match "events/:id/event_starts_at", to: "events#event_starts_at", as: "event_starts_at"
  match "events/:id/event_ends_at", to: "events#event_ends_at", as: "event_ends_at"

  resources :password_resets
  resources :votes
  resources :links
  resources :sessions
  resources :roles
  resources :programs
  # supermodels
  resources :supermodels do
    collection { post :sort }
  end
  match "supermodels/:id/model_status", :to => "supermodels#model_status", :as => "model_status"
  

  root :to => "pages#show", :id => 'home'

 
end
