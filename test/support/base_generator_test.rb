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
    create_dir('config/locales/devise')
    create_file('config/locales/devise.views.en.yml')
    create_file('config/locales/devise.views.pt-BR.yml')
  end

  def create_test_dir
    create_dir('test')
    out_file = new_file('test/test_helper.rb')
    out_file.puts("ENV['RAILS_ENV'] ||= 'test'\n")
    out_file.close
  end

  def create_environment(env)
    create_dir('config/environments')
    out_file = new_file("config/environments/#{env}.rb")
    out_file.puts("Rails.application.configure do\nend")
    out_file.close
  end

  def create_gemfile
    out_file = new_file('Gemfile')
    out_file.puts("source 'https://rubygems.org'\n")
    out_file.close
  end

  def create_application_css
    create_dir('app/assets/stylesheets')
    create_file('app/assets/stylesheets/application.css')
  end

  def create_application_controller
    create_dir('app/controllers')
    out_file = new_file('app/controllers/application_controller.rb')
    out_file.puts("class ApplicationController < ActionController::Base\nend")
    out_file.close
  end

  def create_application_rb
    create_dir('config')
    out_file = new_file('config/application.rb')
    out_file.puts("module App\n  class Application < Rails::Application\n  end\nend")
    out_file.close
  end

  def create_production_rb
    create_dir('config/environments')
    out_file = new_file('config/environments/production.rb')
    out_file.puts("Rails.application.configure do\nend")
    out_file.close
  end

  def create_initializers_dir
    create_dir('config/initializers')
  end

  def create_application_layout
    create_dir('app/views/layouts')
    out_file = new_file('app/views/layouts/application.html.erb')
    out_file.puts("<!DOCTYPE html>\n<html>\n  <head>\n  </head>\n  <body>\n    <%= yield %>\n  </body>\n</html>")
    out_file.close
  end

  def create_file(filepath)
    new_file(filepath).close
  end

  def new_file(filepath)
    File.new("#{destination_root}/#{filepath}", 'w')
  end

  def create_dir(path)
    FileUtils.mkdir_p("#{destination_root}/#{path}")
  end
end
