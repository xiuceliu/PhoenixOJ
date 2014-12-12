class Submission < ActiveRecord::Base
	default_scope order('created_at DESC')
  attr_accessible :language, :code, :verdict, :timeConsumedMillis, :memoryConsumedBytes
  belongs_to :problem
 	belongs_to :user

  def self.search(pid, usn, res, lan)
  	scope = Submission
  	t = User.find(:all, :conditions => ['username = ?', "#{usn}"])
  	if pid.present?
  		scope = scope.where(:problem_id => pid)
  	end
  	if usn.present?
  		scope = scope.where(:user_id => t)
  	end
    if res.present? and res != "All"
      scope = scope.where(:verdict => res)
    end
    if lan.present? and lan != "All"
      scope = scope.where(:language => lan)
    end
    
  	scope.all
  end

end
