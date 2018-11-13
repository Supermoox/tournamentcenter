class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_action :set_tournament
  before_action :authenticate_user!, except: [:index, :show]



  def index
    @rounds = Round.all
  end


  def show
  end

  def new
    @rounds = Round.where(tournament_id: @tournament.id).order("created_at")
    @round = Round.new
  end

  def edit
  end


  def create
    @teams = Team.where(tournament_id: @tournament.id)
    @rounds = Round.where(tournament_id: @tournament.id)
    @teams_num = @teams.count
    @calc_rounds = Math.log(@teams_num, 2).to_i
    @existing_num = @rounds.count
    @num_rounds =  @teams_num - 1
    @total_rounds = @num_rounds * 2


    if @teams_num&1 == 0

      if @tournament.mode == "Swiss_System"
        if @calc_rounds == @existing_num
          @tournament.update(completed: true)
          redirect_to @tournament
        else
          @playing = @teams.where(playing: true)
          if @playing.blank?
            @round = Round.new(round_params)
            @round.tournament_id = @tournament.id
            if @round.save
              redirect_to @tournament
            else
              render 'new'
            end
          else
            redirect_to @tournament
            flash[:notice] = "Games are still being played"
          end
        end
      elsif @tournament.mode == "Round_Robin"
        unless @existing_num == @total_rounds 
          @round = Round.new(round_params)
          @round.tournament_id = @tournament.id
          if @round.save
            redirect_to @tournament
          else
            render 'new'
          end
        end
        if @existing_num == @total_rounds
          @tournament.update(completed: true)
          redirect_to @tournament   
        end
      else
        redirect_to @tournament
        flash[:notice] = "Elimination System is under maintenance try change mode"
      end
    else
      redirect_to @tournament
      flash[:notice] = "The number of teams has to be even!"
    end
  end


  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_round
      @round = Round.find(params[:id])
    end

    def set_tournament
      @tournament = Tournament.find(params[:tournament_id])
    end
    def round_params
      params.require(:round).permit(:name, :tournament_id)
    end
end
