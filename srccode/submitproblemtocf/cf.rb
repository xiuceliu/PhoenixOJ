require 'rubygems'
require 'mechanize'
require 'open-uri'

agent = Mechanize.new
agent.get("http://codeforces.com/enter")
form = agent.page.forms[1]
form.handle = "for_the_money"
form.password = "beyblade!@#@!"
form.click_button

page = agent.get("http://codeforces.com/problemset/submit")
puts page.parser.css("form")
form = agent.page.forms[1]
form.submittedProblemCode = "33A"
form.source = "

#include <iostream>
using namespace std;
int main(){
	puts("Hello, World!")
	return 0;
}

"

form.programTypeId = "1"
form.fields.each {|f| puts f.name}

puts form.submittedProblemCode
puts form.source
puts form.programTypeId

form.click_button