require 'rake/task'
require 'rake/testtask'

task :run do
  sh "ruby lib/slack.rb"
end

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.test_files = FileList['test/*_test.rb']
end

task default: :run
