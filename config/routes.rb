Rails.application.routes.draw do
  root to: 'dashboard#index'


  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get "/logout" => 'sessions#destroy'
  get '/login' => 'login#index'

  get '/cmdb', to: redirect('/cmdb/items')

  get '/cmdb/item_types/:id/ui' => 'item_types#ui'
  get '/cmdb/item_types/:id/ui/:item_id' => 'item_types#ui'

  resources :contracts do
    resources :contract_items, :path=>'items'
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
  end

  resources :people do
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
  end


  scope 'cmdb' do
    get 'items/select_search' => 'items#select_search'
  	resources :items do
      resources :item_relationships, :path=>'rel'
      resources :activity_logs, :path=>'log'
      resources :attachments, :path=>'attachments'
      get 'contracts'
    end
  end

end
