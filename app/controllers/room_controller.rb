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
    @types = Type.order("id DESC")
    respond_to do |format|
      format.html { render :template=>'room/single_player'}
      format.json { render json: @types }
    end
    session[:game_type] = "single_player"
  end

  def current_single_game
    #@single_game = current_user.single_game.order("id DESC").first
    #session[:game_type_id]=params[:type]
    #session[:game_count]=0
  end
  def post_single
    if request.post?
      @single_game = SingleGame.new
      @single_game.user = current_user
      @single_game.select_num = params[:select_num]
      @single_game.time = params[:thought_time]
      @single_game.game_type = params[:type]
      @single_game.score = params[:score]
      @single_game.current_count = (current_user.single_game).count
      @single_game.game_total = (Type.find_by_id(params[:type])).total_num
      puts @single_game.count
      puts @single_game.game_total
      if @single_game.save!
          respond_to do |format|
            format.json{ render json: @single_game }
          end
      end
    end
  end
end
