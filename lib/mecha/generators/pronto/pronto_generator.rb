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
    end
  end
end
