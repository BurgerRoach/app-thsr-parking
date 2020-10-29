# frozen_string_literal: true

# Rakefile
require 'rake/testtask'

CODE = 'lib/'
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
  sh 'ruby example.rb'
  puts 'Example executed'
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
