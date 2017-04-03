module Mecha
  class AppBuilder < Rails::AppBuilder
    def config_application
      inject_into_class('config/application.rb', 'Application') { inject_to_application_rb }
    end

    def config_bitbucket_pipelines
      return unless Mecha.opts.bitbucket_pipelines?
      say('Config Bitbucket Pipelines', :green)
      template('bitbucket-pipelines.yml.erb', 'bitbucket-pipelines.yml')
    end

    def config_devise
      return unless Mecha.opts.devise?
      say('Installing devise from generator', :green)
      system('rails generate devise:install')
      inject_into_file(
        'config/environments/development.rb',
        "\n\n  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
        before: "\nend"
      )
      system('rails generate devise User')
      system('rails generate devise:views')
      inject_into_file(
        'app/controllers/application_controller.rb',
        "\n  before_action :authenticate_user!",
        before: "\nend"
      )
    end

    def config_guardfile
      copy_file('Guardfile', 'Guardfile')
    end

    def config_rubocop
      copy_file('rubocop.yml', '.rubocop.yml')
    end

    def config_test
      copy_file('test_helper.rb', 'test/test_helper.rb', force: true)
      empty_directory_with_keep_file('test/factories')
      empty_directory_with_keep_file('test/support/pages')
    end

    def database_yml
      template "config/databases/#{options[:database]}.yml.erb", 'config/database.example.yml'
      template "config/databases/#{options[:database]}.yml.erb", 'config/database.yml'
      template "config/databases/#{options[:database]}.ci.yml.erb", 'config/database.ci.yml'
    end

    def gemfile
      template('Gemfile.erb', 'Gemfile')
    end

    def gitignore
      super
      @generator.append_file('.gitignore', append_to_gitignore)
    end

    def readme
      template('README.md.erb', 'README.md')
    end

    def config_simplecov
      copy_file('simplecov', '.simplecov')
    end

    def leftovers
      config_application
      config_bitbucket_pipelines
      config_devise
      config_guardfile
      config_rubocop
      config_simplecov
      config_test
    end

    private

    def inject_to_application_rb
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
