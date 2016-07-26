class Event < ApplicationRecord
    
    has_many :guests_event, class_name:"GuestsEvent"
	has_many :guests, :through => :guests_event, :source => :user
	belongs_to :user 
 	mount_uploader :image, AvatarUploader
end
