class UsersController < ApplicationController

before_action :find_user ,only:[:show, :show_friends, :user_join_event,:user_leave_event, :show_my_events]
before_action :authenticate_user!
	def show
	end
    def show_friends
    	@friends = @user.friends
    end

    def find_friends
    	@users = current_user.has_friendshipable_friends
    end
    def user_join_event
    	@user.join_event(params[:event_id])
    	redirect_to '/'
    end
    def show_my_events
    	@my_events = @user.own_events
    end
    def user_leave_event
    	@user.leave_event(params[:event_id])
    	redirect_to '/'
    end
    def find_user
   	   @user = User.find(params[:id])
    end
end
