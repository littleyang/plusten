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
    #@single_game = current_user.single_game.order("id DESC").first
    #session[:game_type_id]=params[:type]
  end
  def post_single
    #@game = params[:data]
    if request.post?
      @single_game = SingleGame.new
      @single_game.user = current_user
      @single_game.select_num = params[:select_num]
      @single_game.time = params[:thought_time]
      @single_game.game_type = params[:type]
      @single_game.score = params[:score]
      if @single_game.save!
          respond_to do |format|
            format.json{ render json: @single_game }
          end
      end
    end
    #puts @single_game
    #puts params[:select_num]
    #puts params[:thought_time]
    #puts @game
  end
end
