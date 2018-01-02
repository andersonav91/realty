class PdfsController < ApplicationController
  def registration_of_real_estate_and_selling_brokers
    # new prawn pdf object
    pdf = Pdfs::RegistrationForm.new()
    pdf_name = "#{Time.now.strftime("%Y%m%dT%H%M%S%z")}.pdf"
    pdf_path = "#{Rails.root}/public/pdfs/#{pdf_name}"

    # save pdf on disc and send pdf by email if it is not exists
    unless File.exists?(pdf_path)
      # save pdf
      pdf.render_file(pdf_path)
      # send email
      PdfsMailer.registration_form(params[:pdf][:email], pdf_name, pdf_path).deliver
      # delete pdf
      File.delete(pdf_path)
    end

  end

  def offer_to_purchase_real_estate
    render json: params
  end

  alias registration_form registration_of_real_estate_and_selling_brokers

  alias offer_to_purchase offer_to_purchase_real_estate
end
