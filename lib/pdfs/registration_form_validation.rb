module Pdfs
  class RegistrationFormValidation
    include ActiveModel::Validations

    attr_accessor :real_estate_licensee_type,
                  :is_designated_agency,
                  :designated_agency_type,
                  :printed_name_of_real_estate_licensee,
                  :license_number,
                  :printed_name_of_real_estate_licensee_type,
                  :name_real_estate_brokerage_firm,
                  :brokerage_firm_real_estate_license_number,
                  :printed_name_of_consumer1,
                  :printed_name_of_consumer2,
                  :customer_type1,
                  :customer_type2,
                  :printed_name_of_consumer1,
                  :printed_name_of_consumer2,
                  :consumer_declines_to_sign_this_notice,
                  :realty_send_email

    # params validation

    validates :real_estate_licensee_type, presence: true, numericality: true, inclusion: { in: [1, 2, 3] }

    validates :is_designated_agency, inclusion: { in: [ true, false ] }

    validates :designated_agency_type, presence: true, numericality: true, inclusion: { in: [1, 2] }

    validates :is_designated_agency, presence: true

    validates :license_number, presence: true, numericality: true

    validates :printed_name_of_real_estate_licensee, presence: true

    validates :printed_name_of_real_estate_licensee_type, presence: true, numericality: true, inclusion: { in: [1, 2] }

    validates :name_real_estate_brokerage_firm, presence: true

    validates :brokerage_firm_real_estate_license_number, presence: true, numericality: true

    validates :printed_name_of_consumer1, presence: true

    validates :printed_name_of_consumer2, presence: true

    validates :customer_type1, presence: true, numericality: true, inclusion: { in: [1, 2] }

    validates :customer_type2, presence: true, numericality: true, inclusion: { in: [1, 2] }

    validates :printed_name_of_consumer1, presence: true

    validates :printed_name_of_consumer2, presence: true

    validates :consumer_declines_to_sign_this_notice, inclusion: { in: [ true, false ] }

    validates_format_of :realty_send_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => false

    def initialize(params={})
      @real_estate_licensee_type = params[:real_estate_licensee_type]
      @is_designated_agency = params[:is_designated_agency]
      @designated_agency_type = params[:designated_agency_type]
      @printed_name_of_real_estate_licensee = params[:printed_name_of_real_estate_licensee]
      @license_number = params[:license_number]
      @printed_name_of_real_estate_licensee_type = params[:printed_name_of_real_estate_licensee_type]
      @name_real_estate_brokerage_firm = params[:name_real_estate_brokerage_firm]
      @brokerage_firm_real_estate_license_number = params[:brokerage_firm_real_estate_license_number]
      @printed_name_of_consumer1 = params[:printed_name_of_consumer1]
      @printed_name_of_consumer2 = params[:printed_name_of_consumer2]
      @customer_type1 = params[:customer_type1]
      @customer_type2 = params[:customer_type2]
      @printed_name_of_consumer1 = params[:printed_name_of_consumer1]
      @printed_name_of_consumer2 = params[:printed_name_of_consumer2]
      @consumer_declines_to_sign_this_notice = params[:consumer_declines_to_sign_this_notice]
      @realty_send_email = params[:realty_send_email]

      # permited params
      params.permit(
          :real_estate_licensee_type,
          :is_designated_agency,
          :designated_agency_type,
          :printed_name_of_real_estate_licensee,
          :license_number,
          :printed_name_of_real_estate_licensee_type,
          :name_real_estate_brokerage_firm,
          :brokerage_firm_real_estate_license_number,
          :printed_name_of_consumer1,
          :printed_name_of_consumer2,
          :customer_type1,
          :customer_type2,
          :printed_name_of_consumer1,
          :printed_name_of_consumer2,
          :consumer_declines_to_sign_this_notice,
          :realty_send_email
      )
    end
  end
end

