require 'test_helper'
require 'mecha/generators/circleci/circleci_generator'

module Mecha
  module Generators
    class CircleciGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::CircleciGenerator

      test 'circleci.yml is created' do
        run_generator([destination_root])
        assert_file 'circle.yml', /TESTOPTS/
      end

      test 'circleci.yml with pronto and danger configs' do
        run_generator([destination_root, '--pronto', '--danger'])
        assert_file 'circle.yml', /PRONTO_PULL_REQUEST_ID/
        assert_file 'circle.yml', /bundle exec danger/
      end
    end
  end
end
