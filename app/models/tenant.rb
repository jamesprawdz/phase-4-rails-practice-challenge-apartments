class Tenant < ApplicationRecord
    has_many :leases
    has_many :apartments, through: :leases

    validates :name, presence: true
    validates :age, numericality: { minimum: 18 }
    
end
