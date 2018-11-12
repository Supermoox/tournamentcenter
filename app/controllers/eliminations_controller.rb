class EliminationsController < ApplicationController
  def show
  	@tournaments = Tournament.order("created_at").first(4)
  end  
end
