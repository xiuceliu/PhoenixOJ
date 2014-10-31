class Discuss < ActiveRecord::Base
  attr_accessible :content
  belongs_to :problem
  belongs_to :user
end
