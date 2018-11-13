class PagesController < ApplicationController
  def home
  	@tournaments = Tournament.order("created_at DESC").first(5)
  end  
  def round_robin
  #	@tournaments = Tournament.order("created_at").first(4)
  end
end
