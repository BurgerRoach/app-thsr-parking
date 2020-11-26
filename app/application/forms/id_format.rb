# frozen_string_literal: true

require 'dry-validation'

module THSRParking
  module Forms
    # check id format
    class IDFormat < Dry::Validation::Contract
      ID_REGEX = /^\d{4}$/.freeze

      params do
        required(:park_id).filled(:string)
      end

      rule(:park_id) do
        key.failure('is an invalid id for a park') unless ID_REGEX.match?(value)
      end
    end
  end
end
