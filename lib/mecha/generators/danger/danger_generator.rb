require 'rails/generators'

module Mecha
  module Generators
    class DangerGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      class_option :simplecov, type: 'boolean', default: false

      def copy_danger
        template('Dangerfile', 'Dangerfile')

        message = <<-MESSAGE.strip_heredoc
          Review your Dangerfile and change the checks for your needs. Also, config the needed environment variables
          in your CI:

          DANGER_GITHUB_API_TOKEN: XXX

          Take a look in the project documentation http://danger.systems/."
        MESSAGE

        say message
      end

      def add_danger_gems
        gem_group :development, :test do
          gem 'danger'
          gem 'danger-github_ext'
          gem 'danger-simplecov_json' if options[:simplecov]
          gem 'danger-todoist'
        end
      end
    end
  end
end
