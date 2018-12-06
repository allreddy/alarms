Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :alarms do
    member do
      put :add_upvote
      put :add_downvote
    end
  end

  root 'alarms#index'


end
