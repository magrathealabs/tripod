require 'rails/generators'

module Mecha
  module Generators
    class TestsGenerator < Rails::Generators::AppBase
      source_root File.join(File.dirname(__FILE__), 'templates')

      def add_test_gems
        gem_group :test do
          gem 'capybara'
          gem 'database_rewinder'
          gem 'poltergeist'
          gem 'ruby-prof'
          gem 'timecop'
          gem 'webmock'
        end
      end

      def add_development_test_gems
        gem_group :development, :test do
          gem 'factory_girl_rails'
          gem 'faker'
        end
      end

      def test_files
        empty_directory_with_keep_file('test/support')
        copy_file('test/test_helper.rb', 'test/test_helper.rb', force: true)
      end

      def say_warking
        message = <<-MESSAGE.strip_heredoc

          Please install PhantomJS `brew install phantomjs`.

        MESSAGE

        say message
      end
    end
  end
end
