class RoomController < ApplicationController
  def index
  end

  def multi_user_room
    @rooms = Room.order(" id DESC")
    respond_to do |format|
      format.html { render :template=>'room/multi_player' }
      format.json { render json: @rooms }
    end
    session[:room_type]="multi_player"
  end

  def single_user_room
    render :template=>'room/single_player'
    session[:room_type] = "single_palyer"
  end

  def current_game
    render :template=>'room/current_game'
    if params[:id]
      session[:room_id] = params[:id]
    end
    if params[:type]
      session[:type] = params[:type]
    end
  end
end
