module Pdfs
  class OfferToPurchaseRealEstateValidation
    include ActiveModel::Validations

    attr_accessor :realty_send_email

    # params validation

    validates_format_of :realty_send_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => false

    def initialize(params={})
      @realty_send_email = params[:realty_send_email]

      # permited params
      params.permit(
          :realty_send_email
      )
    end
  end
end

