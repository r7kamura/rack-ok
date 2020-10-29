# Rack::HealthCheck

A rack middleware to respond to health check request.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-health_check'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rack-health_check

## Usage

Insert `Rack::HealthCheck` to your rack middleware, and the app will respond to `GET /health` with 200 OK.

### For Rails

Insert this before at least ActionDispatch::SSL (enabled by config.force_ssl) to prevent request from being redirected.

```ruby
# config/initializers/health_check.rb
Rails.configuration.middleware.insert(0, Rack::HealthCheck)
```

### For Rack

```ruby
# config.ru
require 'rack/health_check'
use Rack::HealthCheck
```

### Customization

Supports these options:

- `:body` (default: `"OK"`)
- `:path` (default: `"/health"`)

```ruby
use(
  Rack::HealthCheck,
  body: 'Custom response body',
  path: '/custom_health_check_path',
)
```

This gem is designed to easily handle health checks on Rack application,
and is not suitable for complex situations where you need to return non-static response.
In those cases, it's better to make your own for your domain.

## Development

### Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Local installation

To install this gem onto your local machine, run `bundle exec rake install`.

### Release

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/r7kamura/rack-health_check.

## Acknowledgements

This gem is heavily inspired by [rack-health](https://github.com/mirakui/rack-health).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
