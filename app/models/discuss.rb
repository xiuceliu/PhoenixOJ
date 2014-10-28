class Discuss < ActiveRecord::Base
  attr_accessible :user, :content
  belongs_to :problem
end
