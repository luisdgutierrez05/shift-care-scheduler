# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  def after_sign_in_path_for(resource)
    admin_dashboard_index_path
  end
end
