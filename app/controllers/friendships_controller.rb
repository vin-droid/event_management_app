class FriendshipsController < ApplicationController

before_action :authenticate_user!
before_action :find_friendship, only:[:accept_friendship_request, :cancel_friendship_request]



def sent_requests
	@sent_requests = current_user.sent_requests
end

def recieved_requests
	 @recieved_requests = current_user.recieved_requests
end

def cancel_request
	 @friendship.destroy_all
     redirect_to cancel_friendship_request_path
end

def accept_request
	@friendship.update(:status=> "accept")
	redirect_to cancel_friendship_request_path
end
def send_request
	current_user.friendships.create! friend_id: params[:friend_id], status: "pending"
	redirect_to sent_friendship_requests_path
end
private
def find_friendship
	@friendship = Friendship.where(user_id: current_user.id, friend_id: params[:friend_id])
end


end
