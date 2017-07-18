require 'rails/generators'
require 'rails/generators/rails/app/app_generator'
require 'mecha/generators/app/app_builder'

module Mecha
  module Generators
    class AppGenerator < Rails::Generators::AppGenerator
      class_option :database, type: :string, default: 'postgresql'
      class_option :skip_action_cable, type: :boolean, default: true
      class_option :skip_coffee, type: :boolean, default: true
      class_option :skip_turbolinks, type: :boolean, default: true

      source_paths << Rails::Generators::AppGenerator.source_root
      source_paths << File.join(File.dirname(__FILE__), 'templates')
      source_root File.join(File.dirname(__FILE__), 'templates')

      def say_warking
        message = <<-MESSAGE.strip_heredoc

          Please install PostgreSQL `brew install postgres` and NodeJS `brew install nodejs`.

        MESSAGE

        say message
      end

      protected

      def get_builder_class
        Mecha::Generators::AppBuilder
      end
    end
  end
end
