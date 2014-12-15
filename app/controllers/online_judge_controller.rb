class OnlineJudgeController < ApplicationController
  # before_filter :authenticate_user!
  def index
		temp = News.all.sort_by {|u| u.id}
		temp = temp.reverse
		@news = []
		i = 0
		temp.each do |t|
			@news.push(t)
			i += 1
			if i > 3 then
				break
			end
		end
		
		temp = User.all.sort_by {|u| u.arr_prosolved.length}
		temp = temp.reverse
		@users = []
		i = 0
		temp.each do |t|
			@users.push(t)
			i += 1
			if i > 9 then
				break
			end
		end
	end
end
