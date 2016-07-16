require 'fileutils'
require 'json'

class JSONFormatter < XCPretty::Simple
  FILE_PATH = 'build/reports/errors.json'

  def initialize(use_unicode, colorize)
    super
    @warnings = []
    @ld_warnings = []
    @compile_warnings = []
    @errors = []
    @compile_errors = []
    @file_missing_errors = []
    @undefined_symbols_errors = []
    @duplicate_symbols_errors = []
    @failures = {}
    @tests_summary_messages = []
  end

  def format_ld_warning(message)
    @ld_warnings << message
    write_to_file_if_needed
    super
  end

  def format_warning(message)
    @warnings << message
    write_to_file_if_needed
    super
  end

  def format_compile_warning(file_name, file_path, reason, line, cursor)
    @compile_warnings << {
      :file_name => file_name,
      :file_path => file_path,
      :reason => reason,
      :line => line,
      :cursor => cursor
    }
    write_to_file_if_needed
    super
  end

  def format_error(message)
    @errors << message
    write_to_file_if_needed
    super
  end

  def format_compile_error(file, file_path, reason, line, cursor)
    @compile_errors << {
      :file_name => file,
      :file_path => file_path,
      :reason => reason,
      :line => line,
      :cursor => cursor
    }
    write_to_file_if_needed
    super
  end

  def format_file_missing_error(reason, file_path)
    @file_missing_errors << {
      :file_path => file_path,
      :reason => reason
    }
    write_to_file_if_needed
    super
  end

  def format_undefined_symbols(message, symbol, reference)
    @undefined_symbols_errors = {
      :message => message,
      :symbol => symbol,
      :reference => reference
    }
    write_to_file_if_needed
    super
  end

  def format_duplicate_symbols(message, file_paths)
    @duplicate_symbols_errors = {
      :message => message,
      :file_paths => file_paths,
    }
    write_to_file_if_needed
    super
  end

  def format_test_summary(message, failures_per_suite)
    @failures = failures_per_suite
    @tests_summary_messages << message
    write_to_file_if_needed
    super
  end

  def finish
    write_to_file
    super
  end

  def json_output
    {
      :warnings => @warnings,
      :ld_warnings => @ld_warnings,
      :compile_warnings => @compile_warnings,
      :errors => @errors,
      :compile_errors => @compile_errors,
      :file_missing_errors => @file_missing_errors,
      :undefined_symbols_errors => @undefined_symbols_errors,
      :duplicate_symbols_errors => @duplicate_symbols_errors,
      :tests_failures => @failures,
      :tests_summary_messages => @tests_summary_messages
    }
  end
  
  def write_to_file_if_needed
    write_to_file unless XCPretty::Formatter.method_defined? :finish
  end

  def write_to_file
    file_name = ENV['XCPRETTY_JSON_FILE_OUTPUT'] || FILE_PATH
    dirname = File.dirname(file_name)
    FileUtils::mkdir_p dirname

    File.open(file_name, 'w') { |io|
      io.write(JSON.pretty_generate(json_output))
    }
  end
end

JSONFormatter
