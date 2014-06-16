Rails.application.routes.draw do
  devise_for :users

  #User routes
  get 'balance' => 'users#balance', as: :balance
  get 'dashboard' => 'users#dashboard', as: :dashboard
  resources :users

  #transaction routes
  get 'transactions/future' => 'transactions#future_transactions', as: :future_transactions
  get 'transactions/:id/commit' => 'transactions#commit', as: :transaction_commit
  resources :transactions

  #static pages routes
  get 'welcome' => 'static_pages#welcome', as: :welcome


  #root routes (authenticated vs not)
  authenticated :user do
    root :to => "users#dashboard", :as => "authenticated_root"
  end

  root 'static_pages#welcome'

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
