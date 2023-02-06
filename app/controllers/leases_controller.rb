class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        find_lease.destroy
        head :no_content
    end

    private

    def find_lease
        lease = Lease.find(params[:id])
    end

    # create
    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
        end
    
        # destroy
        def render_not_found_response
        render json: { error: "Lease not found" }, status: :not_found
        end
    
        def lease_params
            params.permit(:rent, :apartment_id, :tenant_id)
        end
end
