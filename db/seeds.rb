# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'open-uri'
# require 'active_record/fixtures'

for i in 1000 .. 3000
	agent = Nokogiri::HTML(File.open("#{Rails.root}/Problems/Hdu/#{i}.txt", "r+"))
	title = agent.css("table h1").text
  Problem.create!(:title => title, :ptype => "Hdu",
  :pid => "#{i}")
end
=begin
Problem.delete_all

aFile = File.new("#{Rails.root}/db/codeforces_problemsetproblems.txt", "r")

S = aFile.read

hash = JSON.parse S
hash["result"]["problems"].each do |problem|
  Problem.create!(:title => problem["name"], :ptype => "Codeforces",
  :pid => "#{problem["contestId"]}#{problem["index"]}")
end
=end

aFile.close