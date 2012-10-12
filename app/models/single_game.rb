class SingleGame < ActiveRecord::Base
  attr_accessible :score, :select_num, :time, :type, :user_id
  belongs_to :user
end
