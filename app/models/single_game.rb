class SingleGame < ActiveRecord::Base
  attr_accessible :score, :select_num, :time, :game_type, :user_id
  belongs_to :user
  attr_accessor :game_total
  attr_accessor :current_count
  def caculate_score(num,type)
      if (type == 1)
        score = 50 - num
      elsif(type == 2)
        score = 40 - num
      else(type == 3)
        score = 35 - num
      end
      return score
  end
end
