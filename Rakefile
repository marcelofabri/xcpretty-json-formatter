require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :ci

task :ci do
  Dir.glob('spec/fixtures/*.log') do |file|
    output = "build/#{File.basename(file)}.json"
    sh "cat #{file} | XCPRETTY_JSON_FILE_OUTPUT=#{output} xcpretty -f `bin/xcpretty-json-formatter`"
  end
end
