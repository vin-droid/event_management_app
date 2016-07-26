class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable, :validatable

has_many :comments, dependent: :destroy
has_many :friendships,  class_name:"Friendship", dependent: :destroy
has_many :friends, through: :friendship, dependent: :destroy
has_many :guests_events, class_name:"GuestsEvent"
has_many :events, through: :guests_events, dependent: :destroy
has_many :own_events, class_name:"Event", inverse_of: :user
has_many :sent_requests ,->{where status: "pending"}, class_name: "Friendship"
def recieved_requests
    Friendship.where(friend_id: self.id, status: "pending")
end
def join_event event
    self.guests_events.create!(event_id: event)
end
def leave_event event
    self.guests_events.where(event_id: event).destroy_all
end
def friends
    ids = Array.new
    friendshipable_friend = Friendship.where('(user_id = ? OR friend_id =?) AND (status=?)', self.id, self.id, "accept").map{
        |friendship|
        if friendship.friend_id == self.id
            ids << friendship.user_id
        else
            ids<< friendship.friend_id
        end
    }
    friends = User.where(id: ids)                            
end
def has_friendshipable_friends
    ids = Array.new
    friendshipable_friend = Friendship.where('user_id = ? OR friend_id =?', self.id, self.id).map{
        |friendship|
        if friendship.friend_id == self.id
            ids << friendship.user_id
        else
            ids<< friendship.friend_id
        end
    }
    ids << self.id
    return  User.where('id NOT IN (?)', ids.present? ? ids : [self.id])
end

   def is_already_joined event
        GuestsEvent.where(user_id: self.id, event_id: event).present?
    end

end
