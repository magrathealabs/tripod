require 'rails/generators'

module Mecha
  module Generators
    class SimplecovGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def add_gem
        gem_group :development, :test do
          gem 'simplecov'
          gem 'simplecov-json'
        end
      end

      def config_simplecov_on_test_helper
        inject_into_file('test/test_helper.rb', simplecov_config, after: "ENV['RAILS_ENV'] ||= 'test'")
      end

      private

      def simplecov_config
        <<-SIMPLECOV.strip_heredoc
          require 'simplecov'
          require 'simplecov-json'

          SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
            [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::JSONFormatter]
          )

          SimpleCov.command_name('MiniTest')
          SimpleCov.start do
            load_profile 'test_frameworks'

            add_filter '/bin/'
            add_filter '/config/'
            add_filter '/db/'

            add_group 'Controllers', %w[app/controllers app/policies]
            add_group 'Models', %w[app/models app/validators]
            add_group 'Mailers', 'app/mailers'
            add_group 'Helpers', %w[app/helpers app/presenters]
            add_group 'Services', %w[app/jobs app/services app/uploaders]
            add_group 'Libraries', 'lib'
          end
        SIMPLECOV
      end
    end
  end
end
