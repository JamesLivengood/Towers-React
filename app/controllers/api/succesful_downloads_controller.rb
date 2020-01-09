class Api::SuccesfulDownloadsController < ApplicationController
    def index
      succesful_downloads = SuccesfulDownload.where("lat > ?", params[:latmin]).where("lat < ?", params[:latmax]).where("lng > ?", params[:lngmin]).where("lng < ?", params[:lngmax])
      render json: succesful_downloads.as_json, status: 200
    end
  end
  