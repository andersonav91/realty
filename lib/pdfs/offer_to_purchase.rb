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
      font("#{Rails.root}/public/fonts/TIMES.TTF") do
        move_down 5
        text "Date: <u>#{Time.now.strftime("%Y-%m-%d")}</u>", size: 10, align: :right, inline_format: true

        move_down 5
        text "The BUYER offers to #{@data[:seller]} (SELLER) to buy the property with buildings and improvements thereon, located at #{@data[:seller_address]}, in #{@data[:seller_location]}, MA.", size: 10, align: :left, inline_format: true

        move_down 2
        text "1.<color rgb='FFFFFF'>__</color>The BUYER offers to pay #{ActionController::Base.helpers.number_to_currency(@data[:buyer_offer_to_pay])} for the property as follows:", size: 10, align: :left, inline_format: true

        move_down 3
        text "<color rgb='FFFFFF'>____</color>a. #{ActionController::Base.helpers.number_to_currency(@data[:first_payment_value])} is paid as a deposit to bind this agreement.", size: 10, align: :left, inline_format: true

        move_down 3
        text "<color rgb='FFFFFF'>____</color>b. #{ActionController::Base.helpers.number_to_currency(@data[:secound_payment_value])} is to be paid as an additional deposit on or before #{@data[:secound_payment_date]}, if this agreement is accepted.", size: 10, align: :left, inline_format: true

        move_down 3
        text "<color rgb='FFFFFF'>____</color>c. #{ActionController::Base.helpers.number_to_currency(@data[:third_payment_value])} is the balance to be paid on the closing date of on or before #{@data[:third_payment_date]}.", size: 10, align: :left, inline_format: true

        move_down 3
        text "2.<color rgb='FFFFFF'>__</color>This agreement is subject to the following conditions:", size: 10, align: :left, inline_format: true

        move_down 2
        text_box "a.The BUYER’S ability to obtain a (conventional, FHA, VA, MHFA, etc.) #{get_morgage_type(@data[:mortgage_type])} mortgage in the amount of #{ActionController::Base.helpers.number_to_currency(@data[:mortgage_amount])} by #{@data[:mortgage_value]} at prevailing rates and terms. If the BUYER is unable to obtain the mortgage, the BUYER shall so notify the SELLER in writing by said date, in which event this agreement shall terminate and the SELLER shall return the deposit to the BUYER. The Seller agrees to sign such documents as may be reasonably required by the Buyer's mortgage lender.", size: 10, at: [25, cursor], inline_format: true, width: bounds.width - 15

        move_down 2
      end
    end

    def get_morgage_type(type = 1)
      types = {
          type_1: "Conventional",
          type_2: "FHA",
          type_3: "VA",
          type_4: "MHFA"
      }
      return types["type_#{type}".to_s]
    end
  end
end

