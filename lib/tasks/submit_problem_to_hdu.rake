require 'json'
require 'open-uri'

desc "Submit Problem to Hdu"
task :submit_problem_to_hdu => :environment do
  
  submission = Submission.find(ENV["SUB_ID"])
  current_user = User.find(ENV["USER_ID"])

  agent = Mechanize.new
  agent.get("http://acm.hdu.edu.cn/userloginex.php")
  form = agent.page.forms[2]
  form.username = "PhoenixOJ"
  form.userpass = "woshilalala"
  form.click_button

  page = agent.get("http://acm.hdu.edu.cn/submit.php")
  form = agent.page.forms[2]
  form.problemid = submission.problem.pid
  form.usercode = submission.code
  case submission.language
  when "GNU C++ 4.7" then form.language = "0"
  when "Java 7" then form.language = "5"
  end
  form.click_button

  begin
    agent = Nokogiri::HTML(open("http://acm.hdu.edu.cn/status.php?user=PhoenixOJ")).css("html")
    str = agent.css("html body #fixed_table tr:nth-child(3) td:nth-child(3)").text
  end until str && str != "Queuing" && str != "Running" && str != "Compiling"

  case str
  when "Accepted" then submission.verdict = ARR_VERDICT[1]
  when "Wrong Answer" then submission.verdict = ARR_VERDICT[2]
  when "Time Limit Exceeded" then submission.verdict = ARR_VERDICT[3]
  when "Memory Limit Exceeded" then submission.verdict = ARR_VERDICT[4]
  when "Compilation Error" then submission.verdict = ARR_VERDICT[5]
  when "Runtime Error" then submission.verdict = ARR_VERDICT[6]
  when "Presentation Error" then submission.verdict = ARR_VERDICT[7]
  end

  tml = agent.css("html body #fixed_table tr:nth-child(3) td:nth-child(5)").text
  submission.timeConsumedMillis = tml.gsub!(/\D/, "").to_i
  mml = agent.css("html body #fixed_table tr:nth-child(3) td:nth-child(6)").text
  submission.memoryConsumedBytes = mml.gsub!(/\D/, "").to_i
  submission.save

  id = submission.problem.id
  if submission.verdict == ARR_VERDICT[1]
    if current_user.arr_prosolved.include?(id) == false
      current_user.arr_prosolved.push(id)
    end
    if current_user.arr_profailed.include?(id) == true
      current_user.arr_profailed.delete(id)
    end
  else
    if current_user.arr_prosolved.include?(id) == false && current_user.arr_profailed.include?(id) == false
      current_user.arr_profailed.push(id)
    end
  end
  current_user.save

end