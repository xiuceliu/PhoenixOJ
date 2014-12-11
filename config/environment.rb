# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PheonixOJ::Application.initialize!

ARR_VERDICT = [
	"All",
	"Accepted",
	"Wrong Answer",
	"Time Limit Exceeded",
	"Memory Limit Exceeded",
	"Compile Error",
	"Runtime Error",
	"Presentation Error"
]

ARR_LANGUAGE = [
	"All",
	"GNU C++ 4.7",
	"Java 7",
	"Python 2.7",
	"Ruby 2"
]

ARR_CF_LANGUAGE = [
	"GNU C++ 4.7",
	"Java 7",
	"Python 2.7",
	"Ruby 2"
]