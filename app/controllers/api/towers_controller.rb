class Api::TowersController < ApplicationController
  def create
    towers_params = params[:towers]
    errors = []

    towers_params.each do |tower|
      Tower.create(tower.to_enum.to_h)
    end

    render json: { errors: errors }, status: 200
  end
end
