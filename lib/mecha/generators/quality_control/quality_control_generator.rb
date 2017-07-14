require 'rails/generators'

module Mecha
  module Generators
    class QualityControlGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def copy_reek
        copy_file('reek', '.reek')
      end

      def copy_danger
        template('Dangerfile', 'Dangerfile')
      end

      def add_danger_gems
        gem_group :development, :test do
          gem 'danger'
          gem 'danger-github_ext'
          gem 'danger-todoist'
          gem 'gem danger-simplecov_json' if Mecha.opts.simplecov?
        end
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
          gem('pronto-simplecov', require: false) if Mecha.opts.simplecov?
        end
      end
    end
  end
end
