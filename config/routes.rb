Rails.application.routes.draw do

  get 'videos/all_hardest_videos' => 'videos#all_hardest_videos', as: :all_hardest_videos
  
  resources :videos do 
      resources :ratings
      #resources :watched
  end

  resources :sections do 
    resources :videos, only: [:new]
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  #url to mark a video watched
  get 'videos/:id/watched' => 'watched#watched', as: :watched
  get 'videos/:id/watched/delete' => 'watched#destroy', as: :watched_edit
  get 'users/:id/request_flatiron_status' => 'users#request_flatiron_status', as: :request_flatiron_status

  get '/study_suggestions' => 'application#study_suggestions', as: :study_suggestions

  get '/api/sections', to: 'sections#api_index'
  get '/api/sections/:id/videos', to: 'sections#api_show'

  


  resources :users, only: [:index, :show, :destroy, :update]
  #get '/auth/github/callback' => 'sessions#create'

  
  #resource :users, only: [:show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'application#home'

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
