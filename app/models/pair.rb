class Pair < ApplicationRecord
  belongs_to :round
  after_update :decide_result

  private

  	def decide_result
  		unless self.ended
		    @teams = Team.where(tournament_id: self.round.tournament_id)
		    @home = @teams.where(id: self.home).first
		    @away = @teams.where(id: self.away).first



		    unless self.score_home == nil || self.score_away  == nil 
		    	if self.score_home > self.score_away
		    		@home.update(points: @home.points + 2)

		    		@home.update(wins: @home.wins + 1) 
		    		@away.update(lost: @away.lost + 1)
		    	elsif  self.score_home < self.score_away
		    		@away.update(points: @away.points + 2)

		    		@away.update(wins: @away.wins + 1)
		    		@home.update(lost: @home.lost + 1)     		
		    	else
		    		@away.update(points: @away.points + 1)
		    		@home.update(points: @home.points + 1)
		    		@away.update(draws: @away.draws + 1)
		    		@home.update(draws: @home.draws + 1) 
		    	end

	    		@away.update(played: @away.played + 1)
	    		@home.update(played: @home.played + 1)


	    		@home.update(forced: @home.forced + self.score_home)
	    		@home.update(allowed: @home.allowed + self.score_away)

	    		@away.update(forced: @away.forced + self.score_away)
	    		@away.update(allowed: @away.allowed + self.score_home)
	    		
	    		@home.update(playing: false)
	    		@away.update(playing: false)

	        self.ended = true
	        self.save
		    end
	    end
  	end
end
