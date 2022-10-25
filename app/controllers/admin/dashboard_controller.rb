# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    def index
      @jobs = JobsFilterService.new.call
    end
  end
end
