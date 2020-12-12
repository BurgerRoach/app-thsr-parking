# frozen_string_literal: true

folders = %w[utils gateway]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
