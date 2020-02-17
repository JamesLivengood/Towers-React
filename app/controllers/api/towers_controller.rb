class Api::TowersController < ApplicationController
  def create
    towers_params = params[:towers]
    errors = []

    towers_params.each do |tower|
      Tower.create(tower.to_enum.to_h)
    end

    render json: { errors: errors }, status: 200
  end

  def index
    towers = Tower#.all
                  .where("latitude > ?", params[:latmin])
                  .where("latitude < ?", params[:latmax])
                  .where("longitude > ?", params[:lngmin])
                  .where("longitude < ?", params[:lngmax])
    render json: towers.as_json, status: 200
  rescue => error 
    render json: { error: error.inspect }, status: 500
  end
end
