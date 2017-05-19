require 'rails/generators'

module Mecha
  module Generators
    class CpfCnpjGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def add_gem
        gem 'cpf_cnpj'
      end

      def validator_files
        directory('app/validators', 'app/validators')
      end
    end
  end
end
