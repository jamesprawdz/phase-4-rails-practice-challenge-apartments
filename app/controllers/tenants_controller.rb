class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        render json: find_tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        find_tenant.update!(tenant_params)
        render json :find_tenant, status: :accepted
    end

    def destroy
        find_tenant.destroy
        head :no_content
    end


    private

    def find_tenant
        tenant = Tenant.find(params[:id])
    end

    # create
    def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    # show, update, delete
    def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end
end
