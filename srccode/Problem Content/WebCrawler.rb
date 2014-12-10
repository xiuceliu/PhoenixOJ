require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'json'



aFile = File.new("codeforces_problemsetproblems.txt", "r")

S = aFile.read

hash = JSON.parse S
hash["result"]["problems"].each do |problem|
  if File::exist?("Problems/Codeforces/#{problem["contestId"]}#{problem["index"]}.txt") then
  	next
  end
  puts "#{problem["contestId"]}#{problem["index"]}"
	agent = Nokogiri::HTML(open("http://codeforces.com/problemset/problem/#{problem["contestId"]}/#{problem["index"]}")).css("html")
	aFile = File.new("Problems/Codeforces/#{problem["contestId"]}#{problem["index"]}.txt", "w+")
	aFile.write(agent[0])
	aFile.close
end
