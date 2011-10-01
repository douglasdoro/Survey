MiniAppSurvey::Application.routes.draw do

  root :to => "surveys#index"

  devise_for :users

  resources :users, :only => [:show, :edit, :update]
  
  resources :surveys do 
    member do
      put 'toggle_publish' 
      put 'toggle_watch'
    end
  end
  
  resources :choices, :only => [:create]
    
end
