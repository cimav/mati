Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  get '/cmdb', to: redirect('/cmdb/items')

  get '/cmdb/item_types/:id/ui' => 'item_types#ui'
  get '/cmdb/item_types/:id/ui/:item_id' => 'item_types#ui'


  scope 'cmdb' do
    get 'items/select_search' => 'items#select_search'
  	resources :items do
      resources :item_relationships, :path=>'rel'
      resources :activity_logs, :path=>'log'
    end
  end

 resources :people
end
