require 'spec_helper'
require 'fileutils'
require 'json'

describe 'JSONFormatter' do
  it 'formats raw_kiwi_compilation_fail' do
    verify_file('raw_kiwi_compilation_fail')
  end

  it 'formats raw_kiwi_fail' do
    verify_file('raw_kiwi_fail')
  end

  it 'formats raw_specta_fail' do
    verify_file('raw_specta_fail')
  end

  it 'formats xcodebuild' do
    verify_file('xcodebuild')
  end

  def verify_file(file)
    output = nil
    Dir.mktmpdir do |dir|
      FileUtils.cp("spec/fixtures/#{file}.log", dir)
      Dir.chdir(dir) do
        %x(cat #{file}.log | XCPRETTY_JSON_FILE_OUTPUT=result.json bundle exec xcpretty -f `xcpretty-json-formatter`)
        puts File.read('result.json')
        output = JSON.parse(File.read('result.json'))
      end
    end

    expect(output).to eq json_fixture(file)
  end
end
