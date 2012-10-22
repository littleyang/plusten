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
    if user_session[:game_count].nil?
      user_session[:game_count] = 0
    end
    total_game_num = (Type.find_by_id(params[:type])).total_num
    if current_user.finish_game(user_session[:game_count],total_game_num)
      redirect_to :action=>"index",:controller=>"room"
      flash[:notice] = "you have finish game now"
    end
  end
  def post_single
    if request.post?
      @single_game = SingleGame.new
      @single_game.user = current_user
      @single_game.select_num = params[:select_num]
      @single_game.time = params[:thought_time]
      @single_game.game_type = params[:type]
      @single_game.score = params[:score]
      if @single_game.save!
        if user_session[:game_count].nil?
          user_session[:game_count] = 0
        else
          user_session[:game_count]= user_session[:game_count]+1
        end
        respond_to do |format|
          format.json{ render json: @single_game }
        end
      end
    end
  end

  def current_multi_game
    if user_session[:game_count].nil?
      user_session[:game_count] = 0
    end
    if user_session[:room_id].nil?
      user_session[:room_id] = params[:roomid]
    else
      user_session[:room_id] = user_session[:room_id]
    end
    if user_session[:room_id]
      room = Room.find_by_id(user_session[:room_id])
      if (((room.current_user_num)+1) < (room.usernum))
        room.current_user_num = room.current_user_num + 1
        room.access = true
      elsif (((room.current_user_num)+1) == (room.usernum))
        room.current_user_num = room.current_user_num + 1
        room.access = false
      else
        room.access = false
      end
      room.save!
      if current_user.finish_game(user_session[:game_count],room.gamenum)
        room.access = true
        room.current_user_num = 0
        room.save!
        redirect_to :action=>"index",:controller=>"room"
        flash[:notice] = "you have finish game now"
      end
    end
  end

  def post_multi
    render :nothing => true
    if request.post?
      if user_session[:game_count].nil?
        user_session[:game_count] = 1
      else
        user_session[:game_count]= user_session[:game_count]+1
      end
      user_game = UserGame.new
      room = Room.find_by_id(params[:room_id])
      @game = Game.new
      @game.select_num = params[:select_num]
      @game.time = params[:thought_time]
      @game.current_num = user_session[:game_count]
      @game.room = room
      user_game.user = current_user
      user_game.game = @game
      room.current_post_num = room.current_post_num + 1
      user_game.save!
      if(room.current_post_num < room.usernum)
        room.save!
      else
        room.current_post_num = 0
        room.save!
        show_result = true
      end
      if show_result == true
        respond_to do |format|
          format.json { render json: show_result }
      end
    end
  end
  end
  def get_room_user_num
  end

  def show_multi_game_result
    @result = current_user.caculate_multi_game_result(roomid,user_session[:game_count])
    respond_to do | format |
      format.json { render json: @result }
    end
  end

end
