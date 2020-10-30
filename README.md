# Rack::Ok

[![](https://badge.fury.io/rb/rack-ok.svg)](https://rubygems.org/gems/rack-ok)
[![](https://github.com/r7kamura/rack-ok/workflows/.github/workflows/test.yml/badge.svg)](https://github.com/r7kamura/rack-ok/actions?query=workflow%3A.github%2Fworkflows%2Ftest.yml)

Rack middleware to return OK.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-ok'
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install rack-ok
```

## Usage

Insert `Rack::Ok` to your rack middleware stack, and the app will respond to `GET /health` with 200 OK.

### For Rails

Insert this before at least ActionDispatch::SSL (enabled by config.force_ssl) to prevent request from being redirected.

```ruby
# config/initializers/health_check.rb
Rails.configuration.middleware.insert(0, Rack::Ok)
```

### For Rack

```ruby
# config.ru
require 'rack/ok'
use Rack::Ok
```

### Customization

Supports these options:

- `:body` (default: `"OK"`)
- `:path` (default: `"/health"`)

```ruby
use(
  Rack::Ok,
  body: 'Custom response body',
  path: '/custom_ok_path',
)
```

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Local installation

To install this gem onto your local machine, run `bundle exec rake install`.

### Release

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/r7kamura/rack-ok.

## Acknowledgements

This gem is heavily inspired by [rack-health](https://github.com/mirakui/rack-health).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
