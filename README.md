# Mecha

[![Gem Version](https://badge.fury.io/rb/mecha.svg)](https://badge.fury.io/rb/mecha)
[![Build Status](https://travis-ci.org/magrathealabs/mecha.svg?branch=master)](https://travis-ci.org/magrathealabs/mecha)
[![Dependency Status](https://gemnasium.com/badges/github.com/magrathealabs/mecha.svg)](https://gemnasium.com/github.com/magrathealabs/mecha)
[![Code Climate](https://codeclimate.com/github/magrathealabs/mecha/badges/gpa.svg)](https://codeclimate.com/github/magrathealabs/mecha)
[![Test Coverage](https://codeclimate.com/github/magrathealabs/mecha/badges/coverage.svg)](https://codeclimate.com/github/magrathealabs/mecha/coverage)

Mecha generates Rails apps with the defaults used in Magrathea Labs projects.

## Installation

Install the mecha gem:

```bash
gem install mecha
```

## Usage

```bash
mecha <projectname> --devise --bitbucket-pipelines --sentry
```

This will create a Rails app with name `<projectname>` and add all our defaults. It configures the app to use sass, remove Turbolinks and CoffeeScript, configure Guard, Rubocop and Simplecov. Also, installs Factory Girl, Faker, Timecop, Capybara, Poltergeist, Database Rewinder.

### Available Generators

**Danger**

`--danger` installs and add config for [Danger](http://danger.systems/ruby/). If SimpleCov is installed `danger-simplecov_json` gem is also installed.

**Devise**

`--devise` installs Devise, generates `User`, i18n files and the internationalized views for English and Brazilian Portuguese.

**Bitbucket Pipelines**

`--bitbucket-pipelines` generates the `bitbucket-pipelines.yml` and a special database config for it.

**Pronto**

`--pronto` installs and add config for [Pronto](https://github.com/prontolabs/pronto). If SimpleCov is installed `pronto-simplecov` gem is also installed.

**Sentry**

`--sentry` installs Sentry and adds configs to `application.rb` and `application_controller.rb`. Remember to create an environment
variable with you DSN key. `ENV['DNS']`.

**Simplecov**

`--simplecov` installs Simplecov and adds configs to `test/test_helper.rb`.

## Development

Run `rake test` or simply just `rake` to run tests.

To install Mecha in your local environment run:

```bash
rake install
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/magrathealabs/mecha/issues). This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Thanks

This project is based on [suspenders](https://github.com/thoughtbot/suspenders) from thoughtbot.

## About Magrathea Labs

Mecha is maintained by Magrathea Labs. The names and logos for Magrathea Labs are trademarks of Magrathea Labs.

Magrathea Labs is a team of specialists in Software Engineering, Distributed Systems, Artificial Intelligence and
Data Science. We love to solve challenging problems and build amazing things. Want to do something amazing with us?
We are available for [hire](mailto:contact@magrathealabs.com).
