class CharactersController < ApplicationController
  skip_before_action :authenticate_user!

  def total
    @total = Character.last&.id || 0
    render json: {
      total: @total
    }, status: :ok
  end
end
