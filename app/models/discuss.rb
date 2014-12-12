class Discuss < ActiveRecord::Base
	has_ancestry
  attr_accessible :content, :parent_id
  belongs_to :problem
  belongs_to :user
end
