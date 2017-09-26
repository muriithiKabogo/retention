Rails.application.routes.draw do
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
  root 'dashboard#one'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
