Rails.application.routes.draw do
  
  get 'delayed_jobs/index'

  resources :test
  # for generate devise routes
  #devise_for :users
  
  # for api documentations
  apipie
  
  namespace :api, default: {format: 'json'} do
    
    namespace :v1 do
      
      resources :todo_lists, except: [:new, :edit] do
        resources :todo_items, except: [:new, :edit], default: {format: 'json'}
      end
      
      resources :users, except: [:new, :edit], path: 'user', as: 'user' do
        post :register, to: 'users#create', on: :collection        
        get :list,      to: 'users#index',  on: :collection
        post :login,                        on: :collection
        post :logout,                       on: :collection
      end

      resources :locations, only: [], path: 'location' do
        get :details, on: :collection
        get :long_lat, on: :collection
      end

      resources :cloudinary, only: [] do
        post :upload, on: :collection       
      end
      
    end
    
  end




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
