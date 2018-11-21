class PlayersController < InheritedResources::Base
  before_action :set_player, only: [:show, :edit, :update, :destroy, :increase_goals]


  def increase_goals
    @pair = Pair.where(home: @player.team.id).where(ended: nil).order("created_at DESC").first
    @pair2 = Pair.where(away: @player.team.id).where(ended: nil).order("created_at DESC").first

  	@player.update(goals: @player.goals + 1)
    redirect_to @player.team.tournament

  end

  def update

  end


  private
    def set_player
      @player = Player.find(params[:id])
    end 

    def player_params
      params.require(:player).permit(:name, :goals, :team_id, :temp, :tournament_id)
    end
end

