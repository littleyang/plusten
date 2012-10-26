class Game < ActiveRecord::Base
  attr_accessible :game_type, :room_id, :score, :select_num,:sum, :time,:current_num
  belongs_to :room
  attr_accessible :comment
  attr_accessible :find_id
  has_many :user_game
  has_many :user,:through=>:user_game,:readonly=>false
  attr_accessor :show_result
end
