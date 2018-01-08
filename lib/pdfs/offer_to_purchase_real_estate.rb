module Pdfs
  class OfferToPurchaseRealEstate < Prawn::Document

    attr_accessor :data

    def initialize(data)
      super(top_margin: 30, right_margin: 30, left_margin: 30)

      @data = data

      font_families.update("Arial" => {
          :normal => "#{Rails.root}/public/fonts/ARIAL.TTF",
          :italic => "#{Rails.root}/public/fonts/ARIALI.TTF",
          :bold => "#{Rails.root}/public/fonts/ARIALB.TTF"
      })
    end
  end
end

