# frozen_string_literal: true

# Rakefile
require 'rake/testtask'

CODE = 'app/'
task :default do
  puts `rake -T`
end

desc 'Run tests'
task :spec do
  sh 'ruby spec/api_spec.rb'
  puts 'Tests executed'
end

desc 'Run tests'
task :gateway_spec do
  sh 'ruby spec/gateway_api_spec.rb'
  puts 'Tests executed'
end

desc 'Run example'
task :example do
  sh 'ruby example/api.rb'
  puts 'Api Example executed'
end

namespace :quality do
  desc 'Check Flog'
  task :flog do
    sh "flog #{CODE}"
    puts 'Flog executed'
  end

  desc 'Smell the code'
  task :reek do
    sh "reek #{CODE}"
    puts 'Code smelled'
  end

  desc 'Check rubocop violations'
  task :rubocop do
    sh 'rubocop'
    puts 'Rubocup checked'
  end
end

# desc 'Run tests once'
# Rake::TestTask.new(:spec) do |t|
#   t.pattern = 'spec/*_spec.rb'
#   t.warning = false
# end

namespace :db do
  task :config do
    require 'sequel'
    require_relative 'config/environment' # load config info
    require_relative 'spec/helpers/database_helper'

    def app
      THSRParking::App
    end
  end

  desc 'Run migrations'
  task :migrate => :config do
    Sequel.extension :migration
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.DB, 'app/infrastructure/database/migrations')

    # THSRParking::DatabaseScript::Stations.new.init
  end

  desc 'Insert init Stations data in database'
  task :init_data => :config do
    require_relative 'app/infrastructure/database/scripts/station_script'
    require_relative 'app/infrastructure/database/scripts/restaurant_script'

    THSRParking::DatabaseScript::Stations.new.init
    THSRParking::DatabaseScript::Restaurants.new.init
    puts "Successfully init stations & restaurants data in #{app.environment} database to latest"
  end

  desc 'Wipe records from all tables'
  task :wipe => :config do
    DatabaseHelper.setup_database_cleaner
    DatabaseHelper.wipe_database
  end

  desc 'Delete dev or test database file'
  task :drop => :config do
    if app.environment == :production
      puts 'Cannot remove production database!'
      return
    end

    FileUtils.rm(THSRParking::App.config.DB_FILENAME)
    puts "Deleted #{THSRParking::App.config.DB_FILENAME}"
  end
end

desc 'Run application console (irb)'
task :console do
  sh 'irb -r ./init'
end
