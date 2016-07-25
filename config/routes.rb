Rails.application.routes.draw do


  default_url_options :host => "localhost:3000"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only:[:show] do 
  end
  resources :events do 
    end
	  get 'send_request'      => 'friendships#send_requsest',   as: :send_friendship_request
    delete 'cancel_request' => 'friendships#cancel_requsest', as: :cancel_friendship_request
    get  'accept_request'   => 'friendships#accept_requsest', as: :accept_friendship_request
end
