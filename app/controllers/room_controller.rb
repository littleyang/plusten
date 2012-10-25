class RoomController < ApplicationController
  def index

  end

  def multi_user_room
    @rooms = Room.all
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
    if user_session[:room_url].nil?
      user_session[:room_url] = request.url
      flash.keep[:notice] = %Q[you have getted in the room,please <a href=\"#{url_for(user_session[:room_url])}\">Click Here</a> to Access The Game Room].html_safe
    else
      user_session[:room_url] = user_session[:room_url]
      #render :url=>user_session[:room_url] and return
    end
    total_game_num = (Type.find_by_id(params[:type])).total_num
    if current_user.finish_game(user_session[:game_count],total_game_num)
      user_session[:game_count] = nil
      user_session[:room_url] = nil
      redirect_to :action=>"index",:controller=>"room" and return
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
    else
      user_session[:game_count] = user_session[:game_count]+1
    end
    if user_session[:room].nil?||user_session[:room_url].nil?
      user_session[:room] = Room.find_by_id(params[:roomid])
      user_session[:room_url] = request.url
      if user_session[:room]&&user_session[:room_url]
        room = Room.find_by_id(params[:roomid])
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
      end
    elsif (user_session[:game_count]<1) &&user_session[:room]&&user_session[:room_url]
      user_session[:game_count] = 1
      redirect_to :action=>"have_get_in_room",:controller=>"room" and return
      flash.keep[:notice] = %Q[you have getted in the room,please <a href=\"#{url_for(user_session[:room_url])}\">Click Here</a> to Access The Game Room].html_safe
    else
      user_session[:room] = user_session[:room]
      user_session[:room_url] = user_session[:room_url]
      #redirect_to :action=>"have_get_in_room",:controller=>"room"
      #render :url=>user_session[:room_url] and return
      #flash.keep[:notice] = %Q[you have getted in the room,please <a href=\"#{url_for(user_session[:room_url])}\">Click Here</a> to Access The Game Room].html_safe
      if current_user.finish_game(user_session[:game_count],(user_session[:room]).gamenum)
        room = Room.find_by_id(user_session[:room].id)
        room.access = true
        room.current_user_num = 0
        room.save!
        flash[:notice] = "you have finish game now"
        redirect_to :action=>"index",:controller=>"room" and return
      end
    end
  end

  def post_multi
    render :nothing => true
    if request.post?
      user_game = UserGame.new
      room = Room.find_by_id(params[:room_id])
      @game = Game.new
      @game.select_num = params[:select_num]
      @game.time = params[:thought_time]
      @game.current_num = user_session[:game_count]
      @game.room = room
      user_game.user = current_user
      user_game.game = @game
      user_game.save!
    end
  end
  def show_multi_game_result
    @result = current_user.caculate_multi_game_result(user_session[:room].id,user_session[:game_count])
    respond_to do | format |
      format.json { render json: @result }
    end
  end

  def have_get_in_room
    render :template=>'room/getted_in'
  end

  def next_game
    game = current_user.game.where(:retry=>true,:current_num=>user_session[:game_count])
    game.comment = params[:comment_score]
    puts params[:comment_score]
    if game.save!
      puts "saved"
      puts game
      respond_to do |format|
        format.json { render json: game }
      end
    end
    #user_session[:game_count] = user_session[:game_count] + 1
    #puts user_session[:game_count]
  end

end
