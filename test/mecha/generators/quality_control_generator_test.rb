require 'test_helper'
require 'mecha/generators/quality_control/quality_control_generator'

module Mecha
  module Generators
    class QualityControlGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::QualityControlGenerator

      test 'quality control files are added' do
        create_gemfile
        run_generator

        assert_file '.reek', /IrresponsibleModule/
        assert_file 'Dangerfile', /hitchhiker/
        assert_file 'Gemfile', /gem 'danger'/
        assert_file 'Gemfile', /gem 'pronto'/
      end

      test 'default installation does not install simplecov gems' do
        create_gemfile
        run_generator

        file = File.open("#{destination_root}/Gemfile", 'rt')
        contents = file.read

        assert_no_match(/gem 'danger-simplecov_json'/, contents)
        assert_no_match(/gem 'pronto-simplecov'/, contents)

        file.close
      end

      test 'custom installation with simplecov installs related gems' do
        # create_gemfile
        # run_generator

        # # puts(Mecha.opts[:simplecov])

        # # puts(Mecha.opts[:simplecov] = true)

        # # puts(Mecha.opts[:simplecov])

        # assert_file 'Gemfile', /gem 'danger-simplecov_json'/
        # assert_file 'Gemfile', /gem 'pronto-simplecov'/
      end
    end
  end
end

