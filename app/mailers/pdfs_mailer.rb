class PdfsMailer < ApplicationMailer
  def registration_form(email, pdf_name, pdf_path)
    # attach the pdf
    attachments[pdf_name] = {mime_type: 'application/pdf',
                             content: File.open(pdf_path, 'rb').read}
    # send email
    mail to: email, subject: 'Registration form'
  end

  def offer_to_purchase(email, pdf_name, pdf_path)
    # attach the pdf
    attachments[pdf_name] = {mime_type: 'application/pdf',
                             content: File.open(pdf_path, 'rb').read}
    # send email
    mail to: email, subject: 'Offer to purchase real estate'
  end
end
