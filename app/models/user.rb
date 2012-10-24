class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username
  attr_accessible :userDesc
  attr_accessible :totalscore

  attr_accessor :login
  attr_accessible :login

  has_many :user_game
  has_many :game,:through=>:user_game
  has_many :single_game

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  def finish_game(current,total)
    if (current < total)
      return false
    else
      return true
    end
  end
  def caculate_multi_game_result(id,num)
      @games = Game.where(:room_id=>id,:current_num=>num,:retry=>true)
      sum = get_current_game_sum(id,num)
      update_sum_and_score_column(@games,sum)
      return @games
  end

  def get_current_game_sum(room_id,current_num)
    @games = Game.where(:room_id=>room_id,:current_num=>current_num)
    sum = 0
    for game in @games
      if(game.select_num).nil?
        game.select_num = 0
      end
      sum = sum + game.select_num
    end
    return sum
  end
  def update_sum_and_score_column(games,sum)
    for game in games
      game.sum = sum
      game.score = cacluate_score(game.select_num,sum)
      game.save!
    end
  end
  def cacluate_score(num,sum)
    if (sum < 10)
      score = 0 - num
    elsif( 10 < sum )
      score = 30 - num
    else
      score = 40 -num
    end
    return score
  end
end
