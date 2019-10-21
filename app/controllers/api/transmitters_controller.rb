class Api::TransmittersController < ApplicationController
  def create
    transmitters_params = params[:transmitters]
    errors = []

    transmitters_params.each do |transmitter|
      Transmitter.create(transmitter.to_enum.to_h)
    end

    render json: { errors: errors }, status: 200
  end
end
