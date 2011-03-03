#! /usr/local/bin/ruby

require 'FileUtils'
change_dir = "../changes"
FileUtils.mkdir_p(change_dir)                 # make the changes directory if it doesn't already exist
FileUtils.rm_f Dir.glob("#{change_dir}/*.*")       # delete all the files in changes directory

# generate a file that contains all changes on the branch since last pull
branch = ARGV[0] || "master"
command = "git diff origin/#{branch} #{branch}"
all_changes_file = "#{change_dir}/all-changes.txt"
`#{command} > #{all_changes_file}`

# split that all changes file into multiple files, 
#  each containing the change happened in the file
filedata = File.read all_changes_file
lines = filedata.split(/\n/)
f = File.open("#{change_dir}/others.txt", "w")
lines.each do |line|
  if line.match(/^diff/)
    file_b = line.split(' ').last
    fname = file_b[2..-1]                 # skip the first two characters - 'b/'
    good_fname = fname.gsub('/', '-')
    f.close
    f = File.open("#{change_dir}/#{good_fname}.txt", 'w')
  end
  f.write line+"\n"
end
    
    
    