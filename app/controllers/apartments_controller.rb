class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        render json: find_apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end
    
    def update
        find_apartment.update!(apartment_params)
        render json: find_apartment, status: :accepted
    end

    def destroy
        find_apartment.destroy
        head :no_content
    end

    private

    def find_apartment
        apartment = Apartment.find(params[:id])
    end

    # create
    def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    # show, update, delete
    def render_not_found_response
    render json: { error: "Apartment not found" }, status: :not_found
    end

    def apartment_params
        params.permit(:number)
    end
end
