class Game < ActiveRecord::Base
  attr_accessible :game_type, :room_id, :score, :select_num, :select_one, :select_two, :sum, :time
  belongs_to :room
  has_many :user_game
  has_many :user,:through=>:user_game
end
