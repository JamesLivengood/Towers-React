class Api::TransmittersController < ApplicationController
  def create
    transmitters_params = params[:transmitters]
    errors = []

    transmitters_params.each do |transmitter|
      Transmitter.create(transmitter.to_enum.to_h)
    end

    render json: { errors: errors }, status: 200
  end

  def index
    transmitters = Transmitter#.all
                              .where("latitude > ?", params[:latmin])
                              .where("latitude < ?", params[:latmax])
                              .where("longitude > ?", params[:lngmin])
                              .where("longitude < ?", params[:lngmax])
    render json: transmitters.as_json, status: 200
  end
end
