require 'json'
require 'open-uri'

desc "Submit Problem to Codeforces"
task :submit_problem_to_codeforces => :environment do
  
  submission = Submission.find(ENV["SUB_ID"])
  puts "!!!!!!!!!!!!!!!!!!!!!!!!"
  puts ENV["SUB_ID"]
  puts ENV["USER_ID"]
  puts "!!!!!!!!!!!!!!!!!!!!!!!!"
  current_user = User.find(ENV["USER_ID"])

# Login
  agent = Mechanize.new
  agent.get("http://codeforces.com/enter")
  form = agent.page.forms[1]
  form.handle = "PhoenixOJ"
  form.password = "woshilalala"
  form.click_button
  page = agent.get("http://codeforces.com/problemset/submit")
# Submit Code
  form = agent.page.forms[1]
  form.submittedProblemCode = submission.problem.pid
  form.source = submission.code
  case submission.language
  when "GNU C++ 4.7" then form.programTypeId = "1"
  when "Java 7" then form.programTypeId = "23"
  when "Python 2.7" then form.programTypeId = "7"
  when "Ruby 2" then form.programTypeId = "8"
  end
  form.fields.each {|f| puts f.name}
  form.click_button


  

  begin
        str = open("http://codeforces.com/api/user.status?handle=PhoenixOJ&from=1&count=1").string
        hash = JSON.parse str
      end until hash["result"][0]["verdict"] && hash["result"][0]["verdict"] != "TESTING"
      case hash["result"][0]["verdict"]
      when "OK" then submission.verdict = ARR_VERDICT[1]
      when "WRONG_ANSWER" then submission.verdict = ARR_VERDICT[2]
      when "TIME_LIMIT_EXCEEDED" then submission.verdict = ARR_VERDICT[3]
      when "MEMORY_LIMIT_EXCEEDED" then submission.verdict = ARR_VERDICT[4]
      when "COMPILATION_ERROR" then submission.verdict = ARR_VERDICT[5]
      when "RUNTIME_ERROR" then submission.verdict = ARR_VERDICT[6]
      when "PRESENTATION_ERROR" then submission.verdict = ARR_VERDICT[7]
      end
      submission.timeConsumedMillis = hash["result"][0]["timeConsumedMillis"]
      submission.memoryConsumedBytes = hash["result"][0]["memoryConsumedBytes"]
      submission.save


      id = submission.problem.id
      if submission.verdict == ARR_VERDICT[1]
        if current_user.arr_prosolved.include?(id) == false
          current_user.arr_prosolved.push(id)
        end
        if current_user.arr_profailed.include?(id) == true
          current_user.arr_prosolved.delete(id)
        end
      else
        if current_user.arr_prosolved.include?(id) == false && current_user.arr_profailed.include?(id) == false
          current_user.arr_profailed.push(id)
        end
      end
      current_user.save
end