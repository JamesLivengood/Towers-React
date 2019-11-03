class Api::AntennaSearchUrlsController < ApplicationController
  def create
    urls = AreaUrlGenerator.new(
      url_params[:lat].to_i, url_params[:lng].to_i, url_params[:width].to_i, url_params[:height].to_i
    ).generate_urls!

    render json: urls, status: :ok
  end

  private

  def url_params
    params.require(:antenna_search_urls).permit(:lat, :lng, :width, :height)
  end
end
