Rails.application.routes.draw do
  get 'dashboard/new'
  get 'dashboard/one'
  root 'dashboard#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
