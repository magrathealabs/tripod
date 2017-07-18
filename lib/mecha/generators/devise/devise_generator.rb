require 'rails/generators'
require 'rails/generators/rails/app/app_generator'
require 'mecha/generators/app/app_builder'

module Mecha
  module Generators
    class DeviseGenerator < Rails::Generators::AppBase
      source_root File.join(File.dirname(__FILE__), 'templates')
      source_paths << Rails::Generators::AppGenerator.source_root << File.join(File.dirname(__FILE__), 'templates')

      def install_devise
        gem('devise', '~> 4.2')
        gem('devise-i18n', '~> 1.1.2')
        bundle_command('install')

        stop_spring

        generate('devise:install', verbose: false)
      end

      def generate_devise_user
        generate('devise User')
      end

      def generate_locales
        generate('devise:i18n:locale en')
        generate('devise:i18n:locale pt-BR')

        empty_directory('config/locales/devise')
        move_file('config/locales/devise.views.en.yml', 'config/locales/devise/views.en.yml')
        move_file('config/locales/devise.views.pt-BR.yml', 'config/locales/devise/views.pt-BR.yml')
        remove_file('config/locales/devise.en.yml')
      end

      def generate_localized_views
        generate('devise:i18n:views')
      end

      def config_development_rb
        environment("config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development')
      end

      def config_application_controller
        inject_into_file(
          'app/controllers/application_controller.rb',
          "\n  before_action :authenticate_user!",
          before: "\nend"
        )
      end

      def config_routes
        routes = <<-ROUTES.strip_heredoc
          devise_for :users

          authenticated :user do
            root '/', as: :authenticated_root
          end

          devise_scope :user do
            root 'devise/sessions#new'
          end
        ROUTES

        inject_into_file('config/routes.rb', routes, after: "Rails.application.routes.draw do\n")
      end

      private

      def stop_spring
        run('spring stop')
      end

      def move_file(from, to)
        FileUtils.mv(File.join(destination_root, from), File.join(destination_root, to))
      end
    end
  end
end
