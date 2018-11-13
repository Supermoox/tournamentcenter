class MyJourneysController < ApplicationController
  before_action :authenticate_user!

  def index
  	@tournaments = Tournament.where(user_id: current_user.id).order("created_at").first(4)
  end  
end
