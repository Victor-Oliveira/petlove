# frozen_string_literal: true

class AnimalTypesController < ApplicationController
  before_action :set_animal_type, only: %i[show edit update destroy]

  # GET /animal_types
  # GET /animal_types.json
  def index
    @animal_types = AnimalType.all
  end

  # GET /animal_types/1
  # GET /animal_types/1.json
  def show; end

  # GET /animal_types/new
  def new
    @animal_type = AnimalType.new
  end

  # GET /animal_types/1/edit
  def edit; end

  # POST /animal_types
  # POST /animal_types.json
  def create
    @animal_type = AnimalType.new(animal_type_params)

    respond_to do |format|
      if @animal_type.save
        format.html { redirect(@animal_type, :create, 'animal_type') }
        format.json { render :show, status: :created, location: @animal_type }
      else
        format.html { render :new }
        format.json { render_json(@animal_type.errors, :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /animal_types/1
  # PATCH/PUT /animal_types/1.json
  def update
    respond_to do |format|
      if @animal_type.update(animal_type_params)
        format.html { redirect(@animal_type, :update, 'animal_type') }
        format.json { render :show, status: :ok, location: @animal_type }
      else
        format.html { render :edit }
        format.json { render_json(@animal_type.errors, :unprocessable_entity) }
      end
    end
  end

  # DELETE /animal_types/1
  # DELETE /animal_types/1.json
  def destroy
    @animal_type.destroy
    respond_to do |format|
      format.html { redirect(animal_types_url, :delete, 'animal_type') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_animal_type
    @animal_type = AnimalType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def animal_type_params
    params.require(:animal_type).permit(:name)
  end
end
