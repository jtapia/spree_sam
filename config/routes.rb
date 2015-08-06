Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :shipping_categories, only: [:index, :show]
    end
  end
end
