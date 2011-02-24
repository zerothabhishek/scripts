#! /usr/local/bin/ruby

log_file = ARGV[0] || "development.log"
time_limit = ARGV[1] || 2

f2=File.open("benchmarks.log", "w")
f=File.open log_file

date = ""
action = ""

f.each_line do |line|
  if  line =~ /^Processing/
    l1 = line
    date = l1.match(/\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}/)[0]
    action = l1.match(/\S+Controller\#\S+/)[0]
  end	
  if line =~ /^Completed in/
    l2 = line 
    total_time = l2.match(/\d+\.\d*/)[0]
    too_much = true if (total_time.split(".")[0].to_i > time_limit.to_i)
    f2.write "\n#{action}\t\t\t\t #{date}\t\t #{total_time}\n"  if too_much
  end
end

f.close
f2.close

