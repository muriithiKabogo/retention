Rails.application.routes.draw do
  get 'event_collections/index'

  get 'projects/new'
  post 'projects/create'

  devise_for :users
  get 'dashboard/new'
  get 'dashboard/one'
  get 'dashboard/churn'
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
