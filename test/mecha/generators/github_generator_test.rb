require 'test_helper'
require 'mecha/generators/github/github_generator'

module Mecha
  module Generators
    class GithubGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::GithubGenerator

      test 'github template is created' do
        run_generator([destination_root])
        assert_file '.github/PULL_REQUEST_TEMPLATE.md', /:computer: SCREENSHOTS/
      end
    end
  end
end
