class Api::TransmittersController < ApplicationController
  def create
    debugger
    transmitter_params = params[:transmitter]
    if transmitter = Transmitter.create(transmitter_params)
      render json: {}, status: 200
    else
      render json: { error: { messages: transmitter.errors.full_messages } }, status: 401
    end
  end
end
