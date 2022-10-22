# frozen_string_literal: true

module Api
  module V1
    # Main class for API V1
    class ApiController < ActionController::API
      include Response
      include ExceptionHandler

      # Raises an exception when route is invalid.
      # @returns [ActionController::RoutingError] invalid route exception.
      def routing_error
        error_message = I18n.t('exceptions.invalid_route')
        raise ActionController::RoutingError, error_message
      end
    end
  end
end
