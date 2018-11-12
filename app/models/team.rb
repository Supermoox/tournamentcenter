class Team < ApplicationRecord
  belongs_to :tournament
  after_create :initialize_team

  private

  def initialize_team
  	self.playing = false
  	self.draws = 0
  	self.forced = 0
  	self.allowed = 0
  	self.lost = 0
  	self.played = 0
  	self.wins = 0
  	self.points = 0
  	

    @id = self.tournament.id
    @teams = Team.where("tournament_id = ?", @id).count

    if @teams&1 == 0
      self.seeded = false
      self.host = false
    else
      self.seeded = true
      self.host = true
    end

    self.num = @teams - 1
    self.save
  end
end
