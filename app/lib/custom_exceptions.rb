# frozen_string_literal: true

# Defines custom exceptions subclasses and inherit from StandardError
module CustomExceptions
  class InvalidRequestError < StandardError; end
  class InvalidStatusError < StandardError; end
end
