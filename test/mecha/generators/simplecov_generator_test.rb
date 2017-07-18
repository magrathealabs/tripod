require 'test_helper'
require 'mecha/generators/simplecov/simplecov_generator'

module Mecha
  module Generators
    class SimplecovGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::SimplecovGenerator

      test '.simplecov is created' do
        create_gemfile
        create_test_dir
        run_generator

        assert_file 'Gemfile', /gem 'simplecov'/
        assert_file 'Gemfile', /gem 'simplecov-json'/
        assert_file 'test/test_helper.rb', /require 'simplecov'/
        assert_file 'test/test_helper.rb', /require 'simplecov-json'/
      end
    end
  end
end
