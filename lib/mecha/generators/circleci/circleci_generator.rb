require 'rails/generators'

module Mecha
  module Generators
    class CircleciGenerator < Rails::Generators::Base
      class_option :pronto, type: :boolean, default: false
      class_option :danger, type: :boolean, default: false

      source_root File.join(File.dirname(__FILE__), 'templates')

      def copy_circleci
        template('circle.yml.erb', 'circle.yml')
      end
    end
  end
end
