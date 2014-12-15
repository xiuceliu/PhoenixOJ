class Problem < ActiveRecord::Base
  attr_accessible :content, :title, :pid, :ptype
  has_many :discusses
  has_many :submissions

  def self.search(kwd, src)
		
		scope = Problem
  	if kwd.present?
  		scope = scope.where('title LIKE ?', "%#{kwd}%")
  	end
  	if src.present? and src != "All"
  		scope = scope.where(:ptype => src)
  	end

  	scope.all

  	
  end

end
