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

      # test 'default installation does not add simplecov gems' do
      #   create_gemfile
      #   run_generator

      #   assert_file 'Gemfile', /gem 'danger-simplecov_json'/
      #   assert_file 'Gemfile', /gem 'pronto-simplecov'/
      # end
    end
  end
end
