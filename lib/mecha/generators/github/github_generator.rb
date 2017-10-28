require 'rails/generators'

module Mecha
  module Generators
    class GithubGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def copy_templates
        directory('.github')
      end
    end
  end
end
