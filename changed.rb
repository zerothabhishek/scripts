#! /usr/local/bin/ruby

counter = 0
git_diff = `git diff HEAD`
git_diff.each_line do |line|
  counter += 1  if line.match(/^\+[^\+]/)     # first character of the line is +, second is not (counts all lines starting in +, discards all starting in +++)
end
puts counter  