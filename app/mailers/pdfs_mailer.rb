class PdfsMailer < ApplicationMailer
  def registration_form(email, pdf_name, pdf_path)
    # attach the pdf
    attachments[pdf_name] = File.read(pdf_path)
    # send email
    mail to: email, subject: 'Demo'
  end
end
