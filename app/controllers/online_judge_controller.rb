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
			if i > 4 then
				break
			end
		end
	end
end
