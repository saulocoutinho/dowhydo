Dowhydo::Application.routes.draw do
  
  resources :friendships, :only => [:create, :destroy, :index] do
    collection do
      get :friends
    end
  end

  root :to => 'topics#index'
  
  devise_for :users#, :skip => :sessions
  
  resources :users
 
  resources :tokens, :only => [:create, :destroy]

  resources :argument_votes, :only => :index

  resources :feeds, :only => [:index] do
    collection do
      get :userfeed
    end
  end

  match 'topics/:topic_id/votes', :to => 'topic_votes#index'
  match 'topics/:topic_id/do', :to => 'topics#doo', :via => 'post'
  match 'topics/:topic_id/dont', :to => 'topics#dont', :via => 'post'
  
  resources :topics , :except => [:edit, :update] do
    collection do
      get :trends
    end

    match 'arguments/:argument_id/vote', :to => 'arguments#vote', :via => 'post'
    match 'arguments/:argument_id/votes', :to => 'argument_votes#index'
    
    resources :arguments, :only => [:index, :create, :destroy] do
      collection do
        get :why
        get :whynot
        get :main
      end
    end
  end
  
  resources :arguments, :only => [:index] # removi :create, :destroy se der pau, retorná-los

  #match '*all' => 'arguments#cors_preflight_check', :constraints => {:method => 'OPTIONS'}
  

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
