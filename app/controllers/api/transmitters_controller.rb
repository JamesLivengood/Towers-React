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
    # TODO: there are a ton of somewhat duplicate transmitters, maybe just without different sitenum column?
    #       what to do about these? (maybe check what antennasearch does)
    transmitters = Transmitter#.all
                              .where("latitude > ?", params[:latmin])
                              .where("latitude < ?", params[:latmax])
                              .where("longitude < ?", params[:lngmin])
                              .where("longitude > ?", params[:lngmax])
                              # lng reversed because SQL issue with these numbers being negative number strings
    render json: transmitters.as_json, status: 200
  end
end
