require 'rails/generators'

module Mecha
  module Generators
    class SentryGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def add_gem
        gem 'sentry-raven'
      end

      def config_sentry
        copy_file('sentry.rb', 'config/initializers/sentry.rb')
      end

      def add_sentry_js_partial
        copy_file('_sentry.html.erb', 'app/views/layouts/_sentry.html.erb')
        inject_into_file(
          'app/views/layouts/application.html.erb',
          "\n\n    <%= render 'layouts/sentry' if Rails.env.staging? || Rails.env.production? %>",
          before: "\n  </head>"
        )

        message = <<-MESSAGE.strip_heredoc

          Add SENTRY_JS environment variable.
          Get your Sentry DSN at https://docs.sentry.io/clients/javascript/.

        MESSAGE

        say message
      end

      def config_application_rb
        application('config.filter_parameters << :password')
        environment('config.action_dispatch.show_exceptions = false', env: 'production')
      end

      def config_application_controller
        inject_into_file(
          'app/controllers/application_controller.rb',
          application_controller_set_raven_context,
          before: 'end'
        )

        inject_into_file(
          'app/controllers/application_controller.rb',
          application_controller_before_action,
          after: 'class ApplicationController < ActionController::Base'
        )
      end

      private

      def application_controller_before_action
        "\n  before_action :set_raven_context"
      end

      def application_controller_set_raven_context
        <<-DOC.strip_heredoc

          private

          def set_raven_context
            Raven.user_context(id: session[:current_user_id])
            Raven.extra_context(params: params.to_unsafe_h, url: request.url)
          end
        DOC
      end
    end
  end
end
