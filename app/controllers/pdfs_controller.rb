class PdfsController < ApplicationController

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: { error:  { unknown_parameters: pme.params } },
           status: :bad_request
  end

  def registration_of_real_estate_and_selling_brokers
    # params validation
    pdf_validation = params[:pdf].nil? ? nil : Pdfs::RegistrationFormValidation.new(params[:pdf])

    # if valid form
    if(! pdf_validation.nil? && pdf_validation.valid?)

      # new prawn pdf object
      pdf = Pdfs::RegistrationForm.new(params[:pdf])
      pdf_name = "#{Time.now.strftime("%Y%m%dT%H%M%S%z_registration_form")}.pdf"
      pdf_path = "#{Rails.root}/public/pdfs/#{pdf_name}"

      # create pdf's folder if not exists
      pdf_folder = "#{Rails.root}/public/pdfs/"
      Dir.mkdir(pdf_folder) unless File.exists?(pdf_folder)

      # save pdf on disc and send pdf by email if it is not exists
      unless File.exists?(pdf_path)
        # save pdf
        pdf.render_file(pdf_path)
        # send email
        PdfsMailer.registration_form(params[:pdf][:realty_send_email], pdf_name, pdf_path).deliver
        render json: {
            status: 'ok',
            message: 'The pdf file is generated and sent to the specified email.',
            url: ENV["BACKEND_URL"] + "/pdfs/#{pdf_name}"
        }, status: :ok
      else
        render json: {
            status: 'error',
            message: 'Error generating the pdf, this already exists.'
        }, status: :conflict
      end
    else
      if pdf_validation != nil
        # invalid form
        render json: { status: 'error', message: pdf_validation.errors.full_messages.join(', ') }, status: :not_acceptable
      else
        render json: { status: 'error', message: "Invalid request"}, status: :not_acceptable
      end
    end
  end

  def offer_to_purchase_real_estate
  # params validation
    pdf_validation = params[:pdf].nil? ? nil : Pdfs::OfferToPurchaseRealEstateValidation.new(params[:pdf])

  # if valid form
    if(! pdf_validation.nil? && pdf_validation.valid?)
      # new prawn pdf object
      pdf = Pdfs::OfferToPurchaseRealEstate.new(params[:pdf])
      pdf_name = "#{Time.now.strftime("%Y%m%dT%H%M%S%z_offer_to_purchase_real_estate")}.pdf"
      pdf_path = "#{Rails.root}/public/pdfs/#{pdf_name}"

      # create pdf's folder if not exists
      pdf_folder = "#{Rails.root}/public/pdfs/"
      Dir.mkdir(pdf_folder) unless File.exists?(pdf_folder)

      # save pdf on disc and send pdf by email if it is not exists
      unless File.exists?(pdf_path)
        # save pdf
        pdf.render_file(pdf_path)
        # send email
        PdfsMailer.offer_to_purchase_real_estate(params[:pdf][:realty_send_email], pdf_name, pdf_path).deliver
        render json: {
            status: 'ok',
            message: 'The pdf file is generated and sent to the specified email.',
            url: ENV["BACKEND_URL"] + "/pdfs/#{pdf_name}"
        }, status: :ok
      else
        render json: {
            status: 'error',
            message: 'Error generating the pdf, this already exists.'
        }, status: :conflict
      end
    else
      if pdf_validation != nil
        # invalid form
        render json: { status: 'error', message: pdf_validation.errors.full_messages.join(', ') }, status: :not_acceptable
      else
        render json: { status: 'error', message: "Invalid request"}, status: :not_acceptable
      end
    end
  end

  alias registration_form registration_of_real_estate_and_selling_brokers

  alias offer_to_purchase offer_to_purchase_real_estate
end
