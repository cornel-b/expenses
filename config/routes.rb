Rails.application.routes.draw do
  resources :eentries do
    resources :weekview
  end

  get 'pages/index'

  get 'pages/about'

  root :to => 'pages#index'

  get 'weekview', :to => 'eentries#weekview'
  get 'weekgraph', :to => 'eentries#weekgraph'

  get 'graph/index'
  get 'graph/data', :defaults => { :format => 'json' }
  get 'graph/stacked'


  %w[about contact cv].each do |page|
    get page, controller: 'pages', action: page
  end

end
