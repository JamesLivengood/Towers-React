class Api::TowersController < ApplicationController
  def create
    tower_params = params[:tower]
    if tower = Tower.create(tower_params)
      render json: {}, status: 200
    else
      render json: { error: { messages: tower.errors.full_messages } }, status: 401
    end
  end
end
