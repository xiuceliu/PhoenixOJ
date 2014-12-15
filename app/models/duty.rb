class Duty < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  attr_accessible :message_id, :user_id
end
