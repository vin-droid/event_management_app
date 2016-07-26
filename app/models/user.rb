class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


         has_many :friendships,  class_name:"Friendship", dependent: :destroy
         has_many :friends, through: :friendship, dependent: :destroy
         has_many :guests_event, class_name:"GuestsEvent"
         has_many :events, through: :guests_event, dependent: :destroy
         has_many :own_events, class_name:"Event"


         def join_event event
         	 self.GuestsEvent.create!(event_id: event)
         end

         def leave_event event
         	 self.GuestsEvent.where(event_id: event).destroy_all
         end


end
