class Message < ActiveRecord::Base
   has_many :duties
   has_many :users, :through => :duties
   attr_accessible :sender_ID, :receiver_ID, :receive_name, :state, :sender_delete, :receiver_delete,
                   :send_time, :subject, :content
validates_presence_of :receive_name, :subject, :content
validates :subject, :length => {:maximum => 30}
validates :content, :length => {:maximum => 1000}

def judge_existence
   if User.find_by_username(receive_name) == nil
      errors.add(:receive_name, "This Person Not Found")
   end
end   

validate :judge_existence                  
end
