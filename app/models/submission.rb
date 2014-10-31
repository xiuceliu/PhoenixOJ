class Submission < ActiveRecord::Base
    attr_accessible :language, :code
  	belongs_to :problem
 	belongs_to :user
end
