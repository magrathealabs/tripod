require 'rails/generators'

module Mecha
  module Generators
    class SimplecovGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def add_gem
        gem_group :test do
          gem 'simplecov', require: false
        end
      end

      def copy_simplecov
        copy_file('simplecov', '.simplecov')
      end

      def config_simplecov_on_test_helper
        inject_into_file('test/test_helper.rb', after: "ENV['RAILS_ENV'] ||= 'test'") do
          ["\n", "require 'simplecov'", "require 'simplecov-json'", "SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::JSONFormatter]
)", "SimpleCov.command_name('MiniTest')", 'SimpleCov.start'].join("\n")
        end
      end
    end
  end
end
