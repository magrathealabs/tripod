module Mecha
  class AppBuilder < Rails::AppBuilder
    def config_application
      inject_into_class('config/application.rb', 'Application') do
        <<-DOC
    config.assets.initialize_on_precompile = false
    config.autoload_paths += %W(\#{config.root}/lib \#{config.root}/app/uploaders \#{config.root}/services)
    config.i18n.default_locale = :'pt-BR'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.generators do |g|
      g.view_specs    false
      g.routing_specs false
      g.stylesheets   false
      g.javascripts   false
      g.helper        false
    end
        DOC
      end
    end

    def config_test
      copy_file('test_helper.rb', 'test/test_helper.rb', force: true)
      empty_directory_with_keep_file('test/factories')
      empty_directory_with_keep_file('test/support/pages')
    end

    def database_yml
      template "config/databases/#{options[:database]}.yml", 'config/database.example.yml'
      template "config/databases/#{options[:database]}.yml", 'config/database.yml'
    end

    def gemfile
      template('Gemfile.erb', 'Gemfile')
    end

    def gitignore
      super
      @generator.append_file('.gitignore', append_to_gitignore)
    end

    def guardfile
      copy_file('Guardfile', 'Guardfile')
    end

    def readme
      template('README.md.erb', 'README.md')
    end

    def rubocop
      copy_file('rubocop.yml', '.rubocop.yml')
    end

    def leftovers
      guardfile
      rubocop
      config_application
      config_test
    end

    private

    def append_to_gitignore
      <<-DOC.strip_heredoc
        .DS_Store
        /.byebug_history
        /.env
        /config/database.yml
        /coverage
      DOC
    end
  end
end