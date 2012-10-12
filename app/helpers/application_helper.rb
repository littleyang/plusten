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
end
