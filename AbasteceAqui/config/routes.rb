Rails.application.routes.draw do

  get 'statistics/index'
  get 'statistics' => 'statistics#index'
  get 'statistics/county_anual' => 'county_graph_year#county_anual'
  get 'statistics/state_monthly' => 'state_graph_monthly#state_monthly'
  get 'statistics/state_annual' => 'state_graph_year#state_annual'
  get 'statistics/country_monthly' => 'country_graph_monthly#index'
  get 'statistics/county_monthly' => 'county_graph_monthly#index'

  get '/calculator' => 'calculator#index'
  get '/searcher' => 'search#index'
  get '/search-map-brazil' => 'search#map_brazil'

  get '/map-routes' => 'map_routes#index'
  get '/map-routes/data' => 'map_routes#index_database'

  get 'statistics/ranking_county' => 'county_ranking_fuel#index'
  get 'statistics/ranking_deviation' => 'standard_deviation_rank#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#welcome'

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
