# frozen_string_literal: true

class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[show edit update destroy]
  before_action :set_person

  # GET /animals
  # GET /animals.json
  def index
    @animals = @person.animals
  end

  # GET /animals/1
  # GET /animals/1.json
  def show; end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit; end

  # POST /animals
  # POST /animals.json
  # rubocop:disable Metrics/MethodLength
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html do
          redirect(person_animal_url(@person, @animal), :create, 'animal')
        end

        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render_json(@animal.errors, :unprocessable_entity) }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  # rubocop:disable Metrics/MethodLength
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html do
          redirect(person_animal_url(@person, @animal), :update, 'animal')
        end

        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render_json(animal.errors, :unprocessable_entity) }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect(person_animals_url, :delete, 'animal') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def animal_params
    params.require(:animal)
      .permit(:name, :monthly_cost, :person_id, :animal_type_id)
  end
end
