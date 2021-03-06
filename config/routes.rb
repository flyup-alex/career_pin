Rails.application.routes.draw do
  get 'pins/index'

  get 'pins/create'

  get 'pins/destroy'

  get 'pins/new'

  get 'stalked_pages/index'

  get 'stalked_pages/create'

  get 'stalked_pages/destroy'

  get 'articles/index'

  get 'articles/createdestroy'

  get 'articles/pinned'

  #Companies routes
  root 'companies#welcome'
  devise_for :companies, :controllers => { registrations: 'registrations' }
  resources :companies
  get 'company_logout', to: 'companies#destroy'
  get 'facebook', to: 'companies#facebook'
  get 'facebook_show', to: 'companies#facebook_show'
  get 'twitter', to: 'companies#twitter'
  get 'twitter_show', to: 'companies#twitter_show'
  get 'career_pin_admin', to: 'companies#career_pin_admin'  
  get 'career_pin_add', to: 'companies#add_to_career_pin_outside'

  # Social Users routes - get ":id" should be always at the bottom.
  get 'career', to: 'social_users#career_pins'
  get 'social_users/create'
  delete 'social_users/destroy'
  resources :social_users
  get 'timelines', to: 'social_users#show'
  get '/auth/facebook/callback', to: 'social_users#create'
  get '/auth/twitter/callback', to: 'social_users#create'
  
  
  #StalkedPages routes:
  resources :stalked_pages
  # facebook authentication routes
  resources :pins
  get 'create_pin_from_twitter', to: 'pins#twitter_create' 
  get 'create_pin_from_facebook', to: 'pins#facebook_create' 
  get 'step_by_step', to: 'companies#step_by_step'


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
  get 'company/:id', to: 'social_users#new'
  get 'career-pin/:company_name', to: 'pins#career_pin_outside'
end

