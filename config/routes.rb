Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  get '/cmdb', to: redirect('/cmdb/items')

  get '/cmdb/item_types/:id/ui' => 'item_types#ui'
  get '/cmdb/item_types/:id/ui/:item_id' => 'item_types#ui'


  scope 'cmdb' do
  	resources :items do
      resources :item_relationships, :path=>'rel'
    end
  end

 resources :people
end
