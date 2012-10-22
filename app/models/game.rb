class Game < ActiveRecord::Base
  attr_accessible :game_type, :room_id, :score, :select_num,:sum, :time,:current_num
  belongs_to :room
  has_many :user_game
  has_many :user,:through=>:user_game
  attr_accessor :show_result
end
