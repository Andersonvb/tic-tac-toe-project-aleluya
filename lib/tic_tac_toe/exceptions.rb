# frozen_string_literal: true

module Errors
  # NotAvailbleSpaceError.
  class NotAvailableSpaceError < StandardError
    def initialize(message = 'Space already marked.')
      super(message)
    end
  end

  # ValueError.
  class InvalidValueError < StandardError
    def initialize(message = 'Invalid entered value')
      super(message)
    end
  end
end
