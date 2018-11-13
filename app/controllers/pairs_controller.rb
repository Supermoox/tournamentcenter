class PairsController < ApplicationController
  before_action :set_pair, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  def edit
    if current_user == @pair.round.tournament.user
      @teams = Team.where(tournament_id: @pair.round.tournament_id)
      @home = @teams.where(id: @pair.home).first
      @away = @teams.where(id: @pair.away).first
    else
      redirect_to root_path
    end
  end

 
  def create
    @pair = Pair.new(pair_params)

    respond_to do |format|
      if @pair.save
        format.html { redirect_to @pair, notice: 'Pair was successfully created.' }
        format.json { render :show, status: :created, location: @pair }
      else
        format.html { render :new }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def update
    @pair.ended = true
    if @pair.update(pair_params)
      redirect_to @pair.round.tournament
    else
      render 'edit'
    end
  end


 
  def destroy
    @pair.destroy
    respond_to do |format|
      format.html { redirect_to pairs_url, notice: 'Pair was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
     def set_pair
      @pair = Pair.find(params[:id])
    end

     def pair_params
      params.require(:pair).permit(:home, :away, :score_away, :score_home, :ended, :round_id)
    end
end
