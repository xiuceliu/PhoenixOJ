class Submission < ActiveRecord::Base

	default_scope order('created_at DESC')

    attr_accessible :language, :code
  	belongs_to :problem
 	belongs_to :user

  def self.search(pid, usn)
  	scope = Submission
  	t = User.find(:all, :conditions => ['username = ?', "#{usn}"])
  	if pid.present?
  		scope = scope.where(:problem_id => pid)
  	end
  	if usn.present?
  		scope = scope.where(:user_id => t)
  	end
  	scope.all
  end

end
