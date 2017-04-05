class BaseGeneratorTest < Rails::Generators::TestCase
  destination destination_root
  setup :prepare_destination
  teardown :cleanup_destination_root

  protected

  def prepare_destination
    cleanup_destination_root
    create_destination_root
  end

  def destination_root
    File.expand_path('../tmp', File.dirname(__FILE__))
  end

  def create_destination_root
    FileUtils.mkdir_p(destination_root)
  end

  def cleanup_destination_root
    FileUtils.rm_rf(destination_root)
  end

  def create_devise_app_files
    create_gemfile
    create_environment('development')
    create_application_controller
  end

  def create_environment(env)
    create_dir('config/environments')
    out_file = File.new("#{destination_root}/config/environments/#{env}.rb", 'w')
    out_file.puts("Rails.application.configure do\nend")
    out_file.close
  end

  def create_gemfile
    out_file = File.new("#{destination_root}/Gemfile", 'w')
    out_file.puts("source 'https://rubygems.org'\n")
    out_file.close
  end

  def create_application_css
    create_dir('app/assets/stylesheets')
    File.new("#{destination_root}/app/assets/stylesheets/application.css", 'w').close
  end

  def create_application_controller
    create_dir('app/controllers')
    out_file = File.new("#{destination_root}/app/controllers/application_controller.rb", 'w')
    out_file.puts("class ApplicationController < ActionController::Base\nend")
    out_file.close
  end

  def create_application_rb
    create_dir('config')
    out_file = File.new("#{destination_root}/config/application.rb", 'w')
    out_file.puts("module App\n  class Application < Rails::Application\n  end\nend")
    out_file.close
  end

  def create_dir(path)
    FileUtils.mkdir_p("#{destination_root}/#{path}")
  end
end
