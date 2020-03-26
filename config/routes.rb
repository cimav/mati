Rails.application.routes.draw do
  root to: 'dashboard#index'
  get '/admin' => 'admin#index'


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

  resources :loans do
    resources :activity_logs, :path=>'log'
    post 'return'
  end

  resources :people do
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
    resources :permissions, :path=>'permissions'
    get 'items'
  end

  get '/tickets/all' => 'tickets#all'
  get 'tickets/select_search' => 'tickets#select_search'
  resources :tickets do
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
    resources :ticket_items, :path=>'items'
  end

  get '/problems/all' => 'problems#all'
  resources :problems do
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
    resources :problem_items, :path=>'items'
    resources :problem_tickets, :path=>'tickets'
  end

  get '/changes/all' => 'changes#all'
  resources :changes do
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
    resources :change_items, :path=>'items'
    resources :change_tickets, :path=>'tickets'
    resources :change_problems, :path=>'problems'
  end

  get '/projects/all' => 'projects#all'
  resources :projects do
    resources :activity_logs, :path=>'log'
    resources :attachments, :path=>'attachments'
    resources :project_items, :path=>'items'
    resources :project_tickets, :path=>'tickets'
    resources :project_problems, :path=>'problems'
    resources :project_changes, :path=>'changes'
    resources :project_tasks, :path=>'tasks'
  end

  post '/project_tasks/move/:id/:source/:target/:sibling' => 'project_tasks#move'
  get '/project_tasks/kanban/:project_id' => 'project_tasks#kanban'


  scope 'cmdb' do
    get 'items/select_search' => 'items#select_search'
    get 'items/live_search' => 'items#live_search'
  	resources :items do
      resources :item_relationships, :path=>'rel'
      resources :activity_logs, :path=>'log'
      resources :attachments, :path=>'attachments'
      get 'contracts'
      get 'tickets'
      get 'loans'
    end
  end


  scope 'admin' do
    resources :departments
    resources :services
    resources :agents
  end

  get 'encuesta/:token/:rating' => 'surveys#vote'
  get 'encuesta/:token' => 'surveys#show', :as => 'show_survey'
  patch 'encuesta/:token' => 'surveys#save'



end
