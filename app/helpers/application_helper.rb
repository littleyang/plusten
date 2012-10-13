module ApplicationHelper
  def help_show_login_message
    return "you should login first or register"
  end
  def help_show_room_kind(game_type)
    if game_type=="single_player"
      return "single_game"
    end
    if game_type=="multi_player"
      return "multi_game"
    end
  end
end
