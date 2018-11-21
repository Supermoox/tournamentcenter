class MyTournamentsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@tournaments = Tournament.where(user_id: current_user.id).order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end  
end
