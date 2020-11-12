# frozen_string_literal: true

%w[utils values entities mappers]
  .each do |folder|
    require_relative "#{folder}/init"
  end
