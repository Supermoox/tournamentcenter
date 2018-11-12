class Round < ApplicationRecord
  belongs_to :tournament
  has_many :pairs, dependent: :destroy
  after_create :generate_pairs

  private

  def generate_pairs

    #FOR THE SWISS SYSTEM
    if self.tournament.mode == "Swiss_System" 

    	@id = self.tournament.id
    	@teams_num = Team.where("tournament_id = ?", @id).count
    	@teams = Team.where("tournament_id = ?", @id).order("points DESC").order("forced - allowed DESC")
      @rounds = Round.where("tournament_id = ?", @id)
    	
      @pairs_num = @teams_num /2
    	@count = 1

  		@pairs_num.times do
  			if @count == 1
  				@pair = self.pairs.create!
          @current_team = @teams.first
          @opponents = @teams.where("id != ?", @current_team.id).order("points DESC")
          @matched = false
          @opponents.each do |opponent|
            @found = false
            if !@matched 
              @rounds.each do |round|
                if !@found
                  round.pairs.each do |pair|
                    if !@found
                      if pair.home == opponent.id || pair.away == opponent.id
                        if pair.home == @current_team.id || pair.away == @current_team.id
                          @found = true
                        end
                      end
                    end
                  end
                end
              end
              if !@found
                @pair.home = opponent.id 
                @pair.away = @current_team.id 
                @matched = true
                opponent.update(playing: true)
                @current_team.update(playing: true)
                @pair.save
              end
            end
          end
          @count = 2
        elsif @count == 2
          @pair = self.pairs.create!
          @teams2 = @teams.where(playing: false).order("points DESC")
          @current_team = @teams2.first
          @opponents = @teams2.where("id != ?", @current_team.id).order("points DESC")
          @matched = false
          @opponents.each do |opponent|
            @found = false
            if !@matched 
              @rounds.each do |round|
                if !@found
                  round.pairs.each do |pair|
                    if !@found
                      if pair.home == opponent.id || pair.away == opponent.id
                        if pair.home == @current_team.id || pair.away == @current_team.id
                          @found = true
                        end
                      end
                    end
                  end
                end
              end
              if !@found
                @pair.home = opponent.id 
                @pair.away = @current_team.id 
                @matched = true
                opponent.update(playing: true)
                @current_team.update(playing: true)
                @pair.save
              end
            end
          end
        end
  		end

    #FOR THE LEAGUE ROUND ROBIN

    else 

      @id = self.tournament.id
      @all_teams = Team.where("tournament_id = ?", @id)
      @all_teams.each do |team|
        team.update(playing: false)
      end

     
      @teams = Team.where("tournament_id = ?", @id).order("num")
      @teams_num = @teams.count
      @bound = @teams_num / 2



      @count_rounds = Round.where("tournament_id = ?", @id).count


      @first_legs = @teams_num - 1

      if @count_rounds > @first_legs
        @difference = @count_rounds - @first_legs
        @rounds = Round.where("tournament_id = ?", @id).order("created_at")
        if @difference == 1
          @copy = @rounds.first
          @copy.pairs.each do |pair|
            @pair = self.pairs.create!
            @pair.home = pair.away
            @pair.away = pair.home
            @pair.save
          end
        else
          @i = @difference - 1
          @copy = @rounds.order("created_at").drop(@i).first
          @copy.pairs.each do |pair|
            @pair = self.pairs.create!
            @pair.home = pair.away
            @pair.away = pair.home
            @pair.save
          end          
        end
          
      else
        @bound.times do
          @teams = Team.where("tournament_id = ?", @id).where(playing: false)
          @pair = self.pairs.create!
          @group1 = @teams.where("num < ?", @bound)
          @group2 = @teams.where("num >= ?", @bound)
          @first_team = @group1.order("num").first
          @second_team = @group2.order("num DESC").first


          if @first_team.host && !@second_team.host

            @first_team.update(host: false)
            @second_team.update(host: true)
            @pair.home = @second_team.id 
            @pair.away = @first_team.id 
            @first_team.update(playing: true)
            @second_team.update(playing: true)


            @pair.save
          elsif !@first_team.host && @second_team.host
            @first_team.update(host: true)
            @second_team.update(host: false)
            @pair.home = @first_team.id 
            @pair.away = @second_team.id 
            @first_team.update(playing: true)
            @second_team.update(playing: true)



            @pair.save   
          else
            @first_team.update(host: true)
            @second_team.update(host: false)

            @pair.home = @first_team.id 
            @pair.away = @second_team.id 
            @first_team.update(playing: true)
            @second_team.update(playing: true)
            @pair.save          
          end          
        end

        @teams = Team.where("tournament_id = ?", @id).order("num")
        @team_count = @teams.count - 1
        @fixed = @teams.where("num = ?", 0).first
        @last = @teams.where("num = ?", @team_count).first
        @teams.each do |team|
          unless team == @fixed
            if team == @last
              team.update(num: 1)
            else
              team.update(num: team.num + 1)
            end
          end
        end
      end
    end 
  end
end
