class Problem < ActiveRecord::Base
  attr_accessible :content, :title
  has_many :discusses

  def self.search(search)
  	if search
  		find(:all, :conditions => ['id = ?', "#{search}"])
  	else
  		find(:all)
  	end
  end


end
