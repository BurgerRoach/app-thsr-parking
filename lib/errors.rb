# frozen_string_literal: true

module Errors
  # HTTP Error
  class BadRequest < StandardError; end
  class Unauthorized < StandardError; end
  class NotFound < StandardError; end

  # Options Error
  class OptionsError < StandardError; end
end
