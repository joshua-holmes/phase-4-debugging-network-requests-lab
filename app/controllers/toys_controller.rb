class ToysController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_error_from_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :render_error_from_record_not_found

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find(params[:id])
    toy.update(toy_params)
    render json: toy
  end

  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_error_from_invalid_record(e)
    render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_error_from_record_not_found(e)
    render json: { error: e.record.errors.full_messages }, status: :not_found
  end

end
