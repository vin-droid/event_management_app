class EventsController < ApplicationController

before_action :authenticate_user!
before_action :find_event, only:[:show, :destroy, :update, :edit]


def index
	@events  = Event.all
end
def show
	@guests = Event.where(id: @event.guest_ids) 
	#code here for all guest users
end

def create
	@event = Event.new(find_params)
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
	params[:event].require(:title, :disc, :start_at, :end_at, :image)
end

end
