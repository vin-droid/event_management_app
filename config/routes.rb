Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'events#index'
  resources :users, only:[:show] do 
    member do
      get '/:event_id/join_event'  => 'users#user_join_event'
      get '/:event_id/leave_event' => 'users#user_leave_event'
    end
  end
  resources :events do 
    post 'comment' => 'comments#create', as: :comment
    member do 
      get 'like' 
    end

  end
  get 'friends/requests/sent'      => 'friendships#sent_requests',   as: :sent_friendship_requests
  get 'friends/requests/recieved' => 'friendships#recieved_requests', as: :recieved_friendship_requests
  get 'send_request/:friend_id' => 'friendships#send_request', as: :send_friendship_request
  delete 'cancel_request/:friend_id' => 'friendships#cancel_request', as: :cancel_friendship_request
  get  'accept_request/:friend_id'   => 'friendships#accept_request', as: :accept_friendship_request
  get '/:id/friends' => 'users#friends', as: :friends
  get '/:id/find_friends' => 'users#find_friends', as: :find_friends 
  get '/:id/my_events'  =>'users#show_my_events', as: :my_events

end
