class RoomController < ApplicationController
  def index
  end

  def multi_user_room
    @rooms = Room.order(" id DESC")
    respond_to do |format|
      format.html { render :template=>'room/multi_player' }
      format.json { render json: @rooms }
    end
    session[:game_type]="multi_player"
  end

  def single_user_room
    render :template=>'room/single_player'
    session[:game_type] = "single_player"
  end

  def current_single_game
    #render :template=>'room/current_game'
    #@game = SingleGame.new
    #puts session[:game_type_id]=params[:id]
    #respond_to do |format|
    #  format.html { render :template=>'room/current_game' }
    #  format.json { render json: @game }
    #end
  end
  def post_single
    render :action=>"index"
  end
end
