# frozen_string_literal: true

%w[entities mappers food]
  .each do |folder|
    require_relative "#{folder}/init"
  end
