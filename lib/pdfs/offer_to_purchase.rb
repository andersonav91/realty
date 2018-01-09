module Pdfs
  class OfferToPurchase < Prawn::Document

    attr_accessor :data

    def initialize(data)
      super(top_margin: 30, right_margin: 30, left_margin: 30)

      @data = data

      font_families.update("Arial" => {
          :normal => "#{Rails.root}/public/fonts/ARIAL.TTF",
          :italic => "#{Rails.root}/public/fonts/ARIALI.TTF",
          :bold => "#{Rails.root}/public/fonts/ARIALB.TTF"
      })

      title
    end

    def title
      font("#{Rails.root}/public/fonts/TIMESB.TTF") do
        move_down 2
        text 'OFFER TO PURCHASE REAL ESTATE           FORM B', size: 14, align: :center, inline_format: true
      end
    end
  end
end

