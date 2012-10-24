class Room < ActiveRecord::Base
  attr_accessible :name, :usernum,:gamenum
  attr_accessible :current_user_num
  has_many :game
end
