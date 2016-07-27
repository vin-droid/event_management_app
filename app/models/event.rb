class Event < ApplicationRecord
    
    has_many :guests_events, class_name:"GuestsEvent" ,dependent: :destroy
	has_many :guests, :through => :guests_events, :source => :user
	belongs_to :user, inverse_of: :events
 	mount_uploader :image, AvatarUploader
 	has_many :comments, dependent: :destroy 

 	validates :image,:start_at,:end_at,:image,:disc,:title, presence:true

end
