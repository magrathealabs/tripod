require 'test_helper'
require 'mecha/generators/guard/guard_generator'

module Mecha
  module Generators
    class GuardGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::GuardGenerator

      test 'Guardfile is created' do
        create_gemfile
        run_generator

        assert_file 'Guardfile', %r{guard :minitest, spring: 'bin/rails test' do}
        assert_file 'Gemfile', /  gem 'guard'/
      end
    end
  end
end
