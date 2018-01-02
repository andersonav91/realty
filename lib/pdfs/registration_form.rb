module Pdfs
  class RegistrationForm < Prawn::Document
    def initialize()
      super(top_margin: 70)
      title
    end

    def title
      text "Title", size: 30, style: :bold
    end
  end
end

