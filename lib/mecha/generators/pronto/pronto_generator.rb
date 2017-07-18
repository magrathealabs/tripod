require 'rails/generators'

module Mecha
  module Generators
    class ProntoGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      class_option :simplecov, type: 'boolean', default: false

      def copy_reek
        copy_file('reek', '.reek')
      end

      def copy_flayignore
        copy_file('flayignore', '.flayignore')
      end

      def add_pronto_gems
        gem_group :development, :test do
          gem 'pronto'
          gem 'pronto-brakeman', require: false
          gem 'pronto-fasterer', require: false
          gem 'pronto-flay', require: false
          gem 'pronto-rails_best_practices', require: false
          gem 'pronto-rails_schema', require: false
          gem 'pronto-reek', require: false
          gem 'pronto-rubocop', require: false
          gem('pronto-simplecov', require: false) if options[:simplecov]
        end
      end

      def say_config_message
        message = <<-MESSAGE.strip_heredoc
          If you want to use Pronto in your CI, please config the needed environment variables. Bellow is an example:

          PRONTO_GITHUB_ACCESS_TOKEN: XXX
          PRONTO_PULL_REQUEST_ID: "$(echo $CIRCLE_PULL_REQUEST | grep -o -E '[0-9]+')"
          PRONTO_GITHUB_SLUG: "${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}"
          PRONTO_FORMAT: "%{msg} [%{runner}:%{level}]"
          PRONTO_VERBOSE: true

          Take a look in the project documentation https://github.com/prontolabs/pronto
        MESSAGE

        say message
      end
    end
  end
end
