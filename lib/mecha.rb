require 'slop'

require 'mecha/version'
require 'mecha/generators/app/app_generator'
require 'mecha/generators/assets/assets_generator'
require 'mecha/generators/guard/guard_generator'
require 'mecha/generators/rubocop/rubocop_generator'
require 'mecha/generators/simplecov/simplecov_generator'
require 'mecha/generators/i18n/i18n_generator'
require 'mecha/generators/tests/tests_generator'
require 'mecha/generators/bitbucket_pipelines/bitbucket_pipelines_generator'
require 'mecha/generators/devise/devise_generator'
require 'mecha/generators/sentry/sentry_generator'
require 'mecha/generators/cpf_cnpj/cpf_cnpj_generator'

module Mecha
  def self.opts
    Slop.parse do |o|
      o.bool '--bitbucket-pipelines', 'config Bitbucket Pipelines'
      o.bool '--devise', 'install and config Devise'
      o.bool '--sentry', 'install and config Sentry'
      o.bool '--simplecov', 'install and config Simplecov'
      o.bool '--cpf_cnpj', 'install and config CPF/CNPJ'
      o.on '--version', 'print the gem version' do
        puts Mecha::VERSION
        exit
      end
      o.on '--help', 'list options' do
        puts o
        exit
      end
    end
  end

  def self.start
    Mecha::Generators::AppGenerator.start
    Mecha::Generators::AssetsGenerator.start
    Mecha::Generators::GuardGenerator.start
    Mecha::Generators::RubocopGenerator.start
    Mecha::Generators::I18nGenerator.start
    Mecha::Generators::TestsGenerator.start
    Mecha::Generators::SimplecovGenerator.start if Mecha.opts.simplecov?
    Mecha::Generators::BitbucketPipelinesGenerator.start if Mecha.opts.bitbucket_pipelines?
    Mecha::Generators::DeviseGenerator.start if Mecha.opts.devise?
    Mecha::Generators::SentryGenerator.start if Mecha.opts.sentry?
    Mecha::Generators::CpfCnpjGenerator.start if Mecha.opts.cpf_cnpj?
  end
end
