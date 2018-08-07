require 'rails/generators'

module Mecha
  module Generators
    class I18nGenerator < Rails::Generators::AppBase
      source_root File.join(File.dirname(__FILE__), 'templates')

      CONFIG = [
        "config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]",
        "config.i18n.available_locales = ['pt-BR', 'en']",
        "config.i18n.default_locale = :'pt-BR'"
      ].freeze

      def config_application
        CONFIG.each { |config| application(config) }
      end

      def add_i18n_gem
        gem 'rails-i18n', '~> 5.1.1'
        gem 'route_translator'
      end

      def create_models_locales
        directory('config/locales/models', 'config/locales/models')
      end

      def create_views_locales
        empty_directory_with_keep_file('config/locales/views')
      end
    end
  end
end
