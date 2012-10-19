module RoomHelper
  def help_show_total_score(user)
    total = 0
    games = user.game + user.single_game
    for game in games
      total = total+game.score
    end
    return total
  end
  def show_current_game_num(num)
    return num
  end
  def help_show_left_game_num(type,num)
    total = (Type.find_by_id(type)).total_num
    return total - num
  end
end
