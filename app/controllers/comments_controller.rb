class CommentsController < ApplicationController
def create
	 @comment = Comment.new(find_params)
	 if @comment.save!
	 redirect_to '/' 
	else
		render 'events/index'
	end
end


def find_params
	params[:comment][:user_id] = current_user.id
	params[:comment][:event_id] = params[:event_id]
	params.require(:comment).permit(:event_id, :content, :user_id)	
end

end
