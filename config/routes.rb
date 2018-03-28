Rails.application.routes.draw do
  resources :customers

  get 'event_collections/index'
  get 'projects/analyze'

  get 'projects/new'
  post 'projects/create'
  post 'projects/get_event_poperties'
  post 'projects/search'
  post 'projects/get_data_for_chart'

  devise_for :users
  get 'dashboard/new'
  post 'dashboard/create'
  get 'dashboard/one'
  get 'dashboard/churn'
  post 'dashboard/most_valuable'
  get 'dashboard/most_valuable'
  get 'dashboard/likely_convert'
  get 'dashboard/churn_onboarding'
  get 'dashboard/campaign'
  get 'dashboard/compose'
  get 'dashboard/segment'
  get 'dashboard/create_segment'
  get 'dashboard/compose_segmented'
  get 'dashboard/all_segments'
  get 'dashboard/settings'
  get 'dashboard/emptystate'
  get 'dashboard/segment_empty'
  get 'dashboard/new_segment_emptystate'
  get 'dashboard/campaign_segment'
  get 'dashboard/customer'
  root 'projects#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
