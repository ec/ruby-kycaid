module KYCAID
  class Address < OpenStruct
    extend Client

    def self.create(params)
      p params
      z = KYCAID::Document.create(
        {
          front_file: params[:front_file],
          applicant_id: params[:applicant_id],
          type: 'ADDRESS_DOCUMENT'
        }
      )
      p z
      protected_params = params.slice(:country, :city, :postal_code, :full_address, :applicant_id, :type)

      p protected_params
      response = post("/addresses", protected_params)
      new(JSON.parse(response.body))
    end

    def self.fetch(params)
      protected_params = params.slice(:address_id, :country, :state_or_province, :city, :postal_code, :street_name, :building_number)
      response = patch("/addresses/#{address_id}", protected_params)
      new(JSON.parse(response.body))
    end

    def initialize(response)
      super(response)
      self.raw_response = response
    end
	end
end
