class CharactersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[total]

  before_action :character_params, only: %i[create]
  before_action :set_character, only: %i[show]

  def index
    characters = current_user.characters
    render json: { characters: }, status: :ok
  end

  def show
    render json: { character: @character }, status: :ok
  end

  def create
    character = current_user.characters.new(character_params)

    if character.save
      render json: {
        message: "Character created successfully.",
        character:
      }, status: :ok
    else
      render json: {
        message: "Character couldn't be created successfully.",
        errors: character.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def total
    total = Character.last&.id || 0
    render json: { total: }, status: :ok
  end

  private

  def character_params
    params.require(:character).permit(:name)
  end

  def set_character
    @character = current_user.characters.find(params[:id])
  end
end
