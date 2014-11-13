class Problem < ActiveRecord::Base
  attr_accessible :content, :title
  has_many :discusses
  has_many :submissions

  def self.search(kwd)
  	find(:all, :conditions => ['title LIKE ?', "%#{kwd}%"])
  end

end
