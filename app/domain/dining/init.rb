# frozen_string_literal: true

%w[utils values entities mappers restaurant_hunter]
  .each do |folder|
    require_relative "#{folder}/init"
  end
