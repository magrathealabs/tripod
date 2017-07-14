require 'rails/generators'

module Mecha
  module Generators
    class BitbucketPipelinesGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      class_option :database, type: 'string', default: 'postgresql', aliases: '-d'

      def copy_bitbucket_pipelines
        template("config/databases/#{options[:database]}.bitbucket.yml.erb", 'config/database.bitbucket.yml')
        template('bitbucket-pipelines.yml.erb', 'bitbucket-pipelines.yml')
      end

      private

      def app_name
        File.basename(destination_root).tr('\\', '').tr('. ', '_')
      end
    end
  end
end
