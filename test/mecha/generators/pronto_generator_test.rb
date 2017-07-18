require 'test_helper'
require 'mecha/generators/pronto/pronto_generator'

module Mecha
  module Generators
    class ProntoGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::ProntoGenerator

      test 'pronto files are added' do
        create_gemfile
        run_generator

        assert_file '.reek', /IrresponsibleModule/
        assert_file 'Gemfile', /gem 'pronto'/
      end

      test 'default installation does not install simplecov gems' do
        create_gemfile
        run_generator

        file = File.open("#{destination_root}/Gemfile", 'rt')
        contents = file.read

        assert_no_match(/gem 'pronto-simplecov'/, contents)

        file.close
      end

      test 'custom installation with simplecov installs related gems' do
        create_gemfile
        run_generator(['--simplecov'])

        assert_file 'Gemfile', /gem 'pronto-simplecov'/
      end
    end
  end
end
