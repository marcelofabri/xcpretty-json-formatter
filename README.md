# XCPretty JSON Formatter

Custom formatter for [xcpretty](https://github.com/supermarin/xcpretty) that saves on a JSON file all the errors, warnings and test failures, so you can process them easily later.

## Installation

This formatter is distributed via RubyGems, and depends on a version of `xcpretty` >= 0.0.7 (when custom formatters were introduced). Run:

    gem install xcpretty-json-formatter

## Usage

Specify `xcpretty-json-formatter` as a custom formatter to `xcpretty`:

```bash
#!/bin/bash

xcodebuild | xcpretty -f `xcpretty-json-formatter`
```

By default, `xcpretty-json-formatter` writes the result in `build/reports/errors.json`, but you can change that with an environment variable:

```bash
#!/bin/bash

xcodebuild | XCPRETTY_JSON_FILE_OUTPUT=result.json xcpretty -f `xcpretty-json-formatter`
```

## Thanks

* [Marin Usalj](http://github.com/supermarin) and [Delisa Mason](http://github.com/kattrali) for creating [xcpretty](https://github.com/supermarin/xcpretty).
* [Delisa Mason](http://github.com/kattrali) for creating [xcpretty-travis-formatter](https://github.com/kattrali/xcpretty-travis-formatter), which I used as a guide.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcelofabri/xcpretty-json-formatter.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

