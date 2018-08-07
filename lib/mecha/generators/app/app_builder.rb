module Mecha
  module Generators
    class AppBuilder < Rails::AppBuilder
      def readme
        template('README.md.erb', 'README.md')
      end

      def gemfile
        template('Gemfile.erb', 'Gemfile')
      end

      def ruby_version
        template('ruby-version.erb', '.ruby-version')
      end

      def gitignore
        template('gitignore.erb', '.gitignore')
      end

      def procfile
        template('procfile.erb', 'Procfile')
        template('config/puma.rb.erb', 'config/puma.rb')
      end

      def database_yml
        template "config/databases/#{options[:database]}.yml.erb", 'config/database.example.yml'
        template "config/databases/#{options[:database]}.yml.erb", 'config/database.yml'
      end

      def config_application
        application(config_autoload_paths)
        application(config_generators)
        create_file('app/services/.keep')
        create_file('app/uploaders/.keep')
      end

      def leftovers
        config_application
      end

      private

      def config_autoload_paths
        <<-DOC
    config.autoload_paths += [
      Rails.root.join('app', 'constants'),
      Rails.root.join('app', 'presenters'),
      Rails.root.join('app', 'services'),
      Rails.root.join('app', 'uploaders'),
      Rails.root.join('app', 'validators'),
      Rails.root.join('lib')
    ]
        DOC
      end

      def config_generators
        <<-DOC
    config.generators do |generator|
      generator.view_specs    false
      generator.routing_specs false
      generator.stylesheets   false
      generator.javascripts   false
      generator.helper        false
    end
        DOC
      end
    end
  end
end
