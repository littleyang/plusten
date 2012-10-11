class Room < ActiveRecord::Base
  attr_accessible :name, :usernum,:gamenum
  has_many :game
end
