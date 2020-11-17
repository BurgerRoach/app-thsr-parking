# frozen_string_literal: true

folders = %w[restaurant parking]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
