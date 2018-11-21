class Player < ApplicationRecord
	after_create :initialize_player
  belongs_to :team
  belongs_to :tournament



  private
	  def initialize_player
	  	self.goals = 0
	  	self.temp = 0
	    self.save
	  end
end
