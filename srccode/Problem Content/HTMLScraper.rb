require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

agent = Nokogiri::HTML(File.open("Problems/493A.txt", "r+"))

# Get Time Limit
	str_tml = agent.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.header div.time-limit").text
	str_tml = str_tml[20 .. -1]

# Get Memory Limit
	str_mml = agent.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.header div.memory-limit").text
	str_mml = str_mml[22 .. -1]

# Get Description
	str_des = agent.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div:nth-child(2) p, ui")

# Get Input
	str_input = agent.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.input-specification p, ui")
	puts str_input

# Get Output
	str_output = agent.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.output-specification p")

# Get Sample
	str_sample = agent.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.sample-tests div.sample-test")
