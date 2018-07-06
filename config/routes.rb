Rails.application.routes.draw do
  root to:'photos#top'  
  get 'photos/root'
  get 'sessions/new'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/inbox"
  end
  resources :favorites, only: [:index, :create, :destroy] 
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] 
  resources :photos do    
   collection do
     post :confirm
   end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end