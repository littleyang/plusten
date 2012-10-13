module ApplicationHelper
  def help_show_login_message
    return "you should login first or register"
  end

  def help_show_game_kind
    if session[:room_id]
      return "multi_game"
    end
    if session[:type]
      return "single_game"
    end
  end
  def help_show_room_kind
    if session[:room_type]="single_player"
      return "single_game"
    elsif session[:room_type]="multi_game"
      return "multi_game"
    else
      redirect_to :action=>"index"
    end
  end
end
