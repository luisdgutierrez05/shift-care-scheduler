# frozen_string_literal: true
module Admin
  class DashboardController < ApplicationController
    def index
      @jobs = Api::V1::JobsFilterService.new(default_filter_params).call
    end

    private

    # By default the allocated jobs will be filtered by period of current week
    def default_filter_params
      { start_date: Date.today.beginning_of_week, end_date: Date.today.end_of_week, status: 'pending' }
    end
  end
end
