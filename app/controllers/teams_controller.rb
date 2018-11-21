class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

 


  def edit
    unless user_signed_in? && @team.tournament.user == current_user
      redirect_to root_path
    end
  end
 
  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def update
   
    if @team.update(team_params)
      redirect_to my_tournaments_path
      flash[:notice] = "Team updated"
    else
      render 'edit'
    end
  end
  
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
     def set_team
      @team = Team.find(params[:id])
    end

     def team_params
      params.require(:team).permit(:name, :points, :tournament_id, :wins, :played, :lost, :allowed, :forced, :draws, :playing, :num, :host, :seeded, players_attributes: [:id, :_destroy, :name, :goals, :tournament_id])
    end
end
