class PagesController < ActionController::Base
  layout 'towers'
  after_action :save_user_visit!

  private

  def save_user_visit!
    SiteVisit.create!(
      user_agent: request.user_agent,
      browser_string: browser.to_s,
      ip_address: request.remote_ip,
      params: params.except(:action, :controller),
      geo_data: Geocoder.search(request.remote_ip).first.data
    )
  end
end