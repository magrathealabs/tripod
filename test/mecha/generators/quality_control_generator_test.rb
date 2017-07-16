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

      test 'installs simplecov related gems if simplecov is select' do
        # create_gemfile

        # puts(Mecha.opts[:simplecov])

        # puts(run_generator)

        # puts('is possible to use this') if !Mecha.opts[:simplecov]
      end
    end
  end
end
