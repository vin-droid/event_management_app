class EventsController < ApplicationController

before_action :authenticate_user!
before_action :find_event, only:[:show, :destroy, :update, :edit, :like]
before_action :find_user 


def index
	@events  = Event.all.where.not(user_id: @current_user.id).includes(:guests , comments:[:user]).order('updated_at')
end
def show
	@guests = Event.where(id: @event.guest_ids) 
end
def like
	if !@event.likes.include?(@current_user.id)
	    @event.likes << @current_user.id 
	    @event.save
    else
    	@event.likes.delete(@current_user.id)
    	@event.save
    end
    redirect_to '/'
end


def create
	@event = @current_user.own_events.new(find_params)
	if @event.save!
		redirect_to root_path
		flash[:success] = "Event has been succesfully Created"
	else
		render :new
	end
end
def new
	@event = Event.new
end
def update
	if @event.update(find_params)
		redirect_to root_path
		flash[:success] = "Event has been succesfully updated"
	else
		render :edit
	end
end
def destroy
	if @event.destroy
		redirect_to '/'
		flash[:danger]= "Event has been succesfully deleted"
	end
end


private 

def find_event
	@event = Event.find(params[:id])
end
def find_params
	params.require(:event).permit(:title, :disc, :start_at, :end_at, :image)
end

end
