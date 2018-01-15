module Pdfs
  class OfferToPurchaseValidation
    include ActiveModel::Validations

    attr_accessor :realty_send_email,
                  :seller,
                  :seller_address,
                  :seller_location,
                  :buyer_offer_to_pay,
                  :first_payment_value,
                  :secound_payment_value,
                  :secound_payment_date,
                  :third_payment_value,
                  :third_payment_date,
                  :mortgage_value,
                  :mortgage_type,
                  :mortgage_amount,
                  :mortgage_approve_date,
                  :inspection_expenses,
                  :property_inspected_by,
                  :clause_5_will_apply,
                  :other_provisions,
                  :include_addendum_b_attached,
                  :offer_date_start,
                  :offer_date_end,
                  :mutual_agreement_date,
                  :buyer_name,
                  :offer_status,
                  :offer_status_date,
                  :accepted_date,
                  :accepted_location,
                  :seller_name,
                  :broker,
                  :secound_broker,
                  :agreement_date,
                  :sellers,
                  :buyers,
                  :property_address,
                  :observations

    # params validation

    validates :seller, presence: true

    validates :seller_address, presence: true

    validates :seller_location, presence: true

    validates :buyer_offer_to_pay, presence: true, numericality: true

    validates :first_payment_value, presence: true, numericality: true

    validates :secound_payment_value, presence: true, numericality: true

    validates :secound_payment_date, date: true, presence: true

    validates :third_payment_value, presence: true, numericality: true

    validates :third_payment_date, date: true, presence: true

    validates_format_of :realty_send_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => false

    validates :mortgage_value, presence: true

    validates :mortgage_type, presence: true, numericality: true, inclusion: { in: [1, 2, 3, 4] }

    validates :mortgage_amount, presence: true, numericality: true

    validates :mortgage_approve_date, date: true, presence: true

    validates :inspection_expenses, presence: true, numericality: true

    validates :property_inspected_by, presence: true

    validates :clause_5_will_apply, inclusion: { in: [ true, false ] }

    validates :other_provisions, presence: true

    validates :include_addendum_b_attached, inclusion: { in: [ true, false ] }

    validates :offer_date_start, date: true, presence: true

    validates :mutual_agreement_date, date: true, presence: true

    validates :offer_date_end, date: true, presence: true

    validates :buyer_name, presence: true

    validates :offer_status, presence: true, numericality: true, inclusion: { in: [1, 2] }

    validates :offer_status_date, date: true, presence: true

    validates :accepted_date, date: true, presence: true

    validates :accepted_location, presence: true

    validates :seller_name, presence: true

    validates :broker, presence: true

    validates :secound_broker, presence: true

    validates :agreement_date, date: true, presence: true

    validates :sellers, presence: true

    validates :buyers, presence: true

    validates :property_address, presence: true

    validates :observations, presence: true

    def initialize(params={})
      @realty_send_email = params[:realty_send_email]
      @seller = params[:seller]
      @seller_address = params[:seller_address]
      @seller_location = params[:seller_location]
      @buyer_offer_to_pay = params[:buyer_offer_to_pay]
      @first_payment_value = params[:first_payment_value]
      @secound_payment_value = params[:secound_payment_value]
      @secound_payment_date = params[:secound_payment_date].to_date
      @third_payment_value = params[:third_payment_value]
      @third_payment_date = params[:third_payment_date].to_date
      @mortgage_value = params[:mortgage_value]
      @mortgage_type = params[:mortgage_type]
      @mortgage_amount = params[:mortgage_amount]
      @mortgage_approve_date = params[:mortgage_approve_date].to_date
      @inspection_expenses = params[:inspection_expenses]
      @property_inspected_by = params[:property_inspected_by]
      @clause_5_will_apply = params[:clause_5_will_apply]
      @other_provisions = params[:other_provisions]
      @include_addendum_b_attached = params[:include_addendum_b_attached]
      @offer_date_start = params[:offer_date_start].to_date
      @offer_date_end = params[:offer_date_end].to_date
      @mutual_agreement_date = params[:mutual_agreement_date].to_date
      @buyer_name = params[:buyer_name]
      @offer_status = params[:offer_status]
      @offer_status_date = params[:offer_status_date].to_date
      @accepted_date = params[:accepted_date].to_date
      @accepted_location = params[:accepted_location]
      @seller_name = params[:seller_name]
      @broker = params[:broker]
      @secound_broker = params[:secound_broker]
      @agreement_date = params[:agreement_date].to_date
      @sellers = params[:sellers]
      @buyers = params[:buyers]
      @property_address = params[:property_address]
      @observations = params[:property_address]

      # permited params
      params.permit(
          :realty_send_email,
          :seller,
          :seller_address,
          :seller_location,
          :buyer_offer_to_pay,
          :first_payment_value,
          :secound_payment_value,
          :secound_payment_date,
          :third_payment_value,
          :third_payment_date,
          :mortgage_value,
          :mortgage_type,
          :mortgage_amount,
          :mortgage_approve_date,
          :inspection_expenses,
          :property_inspected_by,
          :clause_5_will_apply,
          :other_provisions,
          :include_addendum_b_attached,
          :offer_date_start,
          :offer_date_end,
          :mutual_agreement_date,
          :buyer_name,
          :offer_status,
          :offer_status_date,
          :accepted_date,
          :accepted_location,
          :seller_name,
          :broker,
          :secound_broker,
          :agreement_date,
          :sellers,
          :buyers,
          :property_address,
          :observations
      )
    end
  end
end

