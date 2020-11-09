# frozen_string_literal: true

%w[entities mappers restaurant_hunter]
  .each do |folder|
    require_relative "#{folder}/init"
  end
