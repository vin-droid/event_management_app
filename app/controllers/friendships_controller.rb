class FriendshipsController < ApplicationController

before_action :authenticate_user!
before_action :find_user 
before_action :find_friendship, only:[:accept_request, :cancel_request ,:cancel_own_request]


def sent_requests
	@sent_requests = @current_user.sent_requests
end

def recieved_requests
	 @recieved_requests = @current_user.recieved_requests
end

def cancel_own_request
	 #@friendship = Friendship.find_by(user_id: @current_user.id, friend_id: params[:friend_id])
     @friendship.destroy
     redirect_to sent_friendship_requests_path
end

def cancel_request
	@friendship.destroy
	redirect_to recieved_friendship_requests_path
end

def accept_request
	@friendship.update_attribute(:status, "accept")
	redirect_to recieved_friendship_requests_path
end
def send_request
	@current_user.friendships.create! friend_id: params[:friend_id], status: "pending"
	redirect_to  find_friends_path(@current_user)
end

def find_friendship
	#@friendship = Friendship.find_by(friend_id: @current_user.id, user_id: params[:friend_id])
    @friendship = Friendship.where("(user_id=? AND friend_id=?) OR (friend_id=? AND user_id=?)", current_user.id, params[:friend_id], current_user.id, params[:friend_id]).first
end


end
