require 'test_helper'
require 'mecha/generators/danger/danger_generator'

module Mecha
  module Generators
    class DangerGeneratorTest < BaseGeneratorTest
      tests Mecha::Generators::DangerGenerator

      test 'Danger files are added' do
        create_gemfile
        run_generator

        assert_file 'Dangerfile', /hitchhiker/
        assert_file 'Gemfile', /gem 'danger'/
      end

      test 'default installation does not install simplecov gems' do
        create_gemfile
        run_generator

        file = File.open("#{destination_root}/Gemfile", 'rt')
        contents = file.read

        assert_no_match(/gem 'danger-simplecov_json'/, contents)

        file.close
      end

      test 'custom installation with simplecov installs related gems' do
        create_gemfile
        run_generator(['--simplecov'])

        assert_file 'Gemfile', /gem 'danger-simplecov_json'/
      end
    end
  end
end
