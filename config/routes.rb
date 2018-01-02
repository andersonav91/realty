Rails.application.routes.draw do

  # Pdfs Controller
  post '/pdfs/registration_form', to: 'pdfs#registration_form', as: 'pdf_registration_form'
  post '/pdfs/offer_to_purchase', to: 'pdfs#offer_to_purchase', as: 'pdf_offer_to_purchase'

end
