require 'pathname'
ROOT = Pathname.new(File.expand_path('..', __dir__))
$LOAD_PATH.unshift((ROOT + 'lib').to_s)
$LOAD_PATH.unshift((ROOT + 'spec').to_s)

require 'bundler/setup'

require 'rspec'

# Use coloured output, it's the best.
RSpec.configure do |config|
  config.filter_gems_from_backtrace 'bundler'
  config.color = true
  config.tty = true
end

def fixture(file)
  File.read("spec/fixtures/#{file}")
end

def json_fixture(file, parsing = true)
  content = fixture("#{file}.json")
  content = JSON.parse(content) if parsing

  content
end
