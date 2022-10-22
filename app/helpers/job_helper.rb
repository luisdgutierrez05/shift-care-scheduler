# frozen_string_literal: true

module JobHelper
  def plumber_links(job)
    job.plumbers.each_with_object([]) do |plumber, html_links|
      html_links << link_to(plumber.name, admin_plumber_path(plumber.id))
    end.join(', ').html_safe
  end

  def current_plumbers
    Plumber.all.collect { |plumber| [plumber.name.titleize, plumber.id] }
  end

  def current_clients
    Client.all.collect { |client| [client.name.titleize, client.id] }
  end
end
