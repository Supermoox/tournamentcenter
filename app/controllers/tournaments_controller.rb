class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  before_action :authenticate_user!, except: [:index, :show]
 
  def index
    @tournaments = Tournament.where(["name LIKE ?","%#{params[:search]}%"]).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    @tournament = @tournament.where(publish: true)
  end

 
  def show
    @rounds = Round.where(tournament_id: @tournament.id).order("created_at").paginate(page: params[:page], per_page: 1)
    @round = Round.new
    @teams = Team.where(tournament_id: @tournament.id).order("points DESC").order("forced - allowed DESC").order("name")
    @count = 0
    @g_count = 0
    @players = Player.where(tournament_id: @tournament.id).order("goals DESC").order("name")

    @playing = @teams.where(playing: true)
  end

  def new
    @tournament = current_user.tournaments.build
  end
   
  def edit
    unless user_signed_in? && @tournament.user == current_user
      redirect_to root_path
    end
  end
 
 def publish
   @tournament.update(publish: true)
   redirect_to @tournament
   flash[:notice] = "Tournament Published!"
 end 

 def unpublish
   @tournament.update(publish: false)
   redirect_to @tournament
   flash[:notice] = "Tournament Now in Private mode!"
 end

  def create
    @tournament = current_user.tournaments.build(tournament_params)
    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    if @tournament.update(tournament_params)
      redirect_to my_tournaments_path
      flash[:notce] = "Tournament Updated!"
    else
      render 'update'
    end
  end
 
  def destroy


    if  @tournament.destroy
      redirect_to my_tournaments_path
      flash[:notce] = "Tournament Deleted!"
    end
  end

  private
 
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end
 
    def tournament_params
      params.require(:tournament).permit(:name, :mode, :kind, :publish, :image, teams_attributes: [:id, :_destroy, :name, :points, :host, :seeded, :completed, :tournament_id, players_attributes: [:id, :_destroy, :name, :goals]])
    end
end
