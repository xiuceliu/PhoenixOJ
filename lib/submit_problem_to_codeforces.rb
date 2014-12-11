class SubmitProblemToCodeforces < Struct.new(:sub, :index, :source, :language, :cur_problem, :cur_user)

  def perform

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
  form.submittedProblemCode = index
  form.source = source
  case language
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
  

  # sub = Submission.find(:id => sub_id)
  
  case hash["result"][0]["verdict"]
      when "OK" then sub.verdict = ARR_VERDICT[1]
      when "WRONG_ANWSER" then sub.verdict = ARR_VERDICT[2]
      when "TIME_LIMIT_EXCEEDED" then sub.verdict = ARR_VERDICT[3]
      when "MEMORY_LIMIT_EXCEEDED" then sub.verdict = ARR_VERDICT[4]
      when "COMPILATION_ERROR" then sub.verdict = ARR_VERDICT[5]
      when "RUNTIME_ERROR" then sub.verdict = ARR_VERDICT[6]
      when "PRESENTATION_ERROR" then sub.verdict = ARR_VERDICT[7]
  end
  sub.problem = cur_problem
  sub.user = cur_user
  sub.timeConsumedMillis = hash["result"][0]["timeConsumedMillis"]
  sub.memoryConsumedBytes = hash["result"][0]["memoryConsumedBytes"]
  sub.save

end
end
