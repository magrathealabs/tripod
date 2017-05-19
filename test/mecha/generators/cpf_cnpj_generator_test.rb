require 'test_helper'
require 'mecha/generators/cpf_cnpj/cpf_cnpj_generator'

module Mecha
  module Generators
    class CpfCnpjGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::CpfCnpjGenerator

      test 'create cpf_cnpj files' do
        create_gemfile
        run_generator

        assert_file 'Gemfile', /gem 'cpf_cnpj'/
        assert_file 'app/validators/cnpj_format_validator.rb', /    record.errors.add/
      end
    end
  end
end
