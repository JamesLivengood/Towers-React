class Api::FailedDownloadsController < ApplicationController
 
    def index
      failed_downloads = FailedDownload.where("lat > ?", params[:latmin])
                                       .where("lat < ?", params[:latmax])
                                       .where("lng > ?", params[:lngmin])
                                       .where("lng < ?", params[:lngmax])
      render json: failed_downloads.as_json, status: 200
    end
  end
  