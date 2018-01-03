module Pdfs
  class RegistrationForm < Prawn::Document
    def initialize()
      super(top_margin: 30, right_margin: 30, left_margin: 30)
      title
    end

    def title

      logo = "#{Rails.root}/public/imgs/logo.png"
      image logo, :at => [16,720], width: 69, height: 70

      indent(100) do
        font("#{Rails.root}/public/fonts/MTCORSVA.TTF") do
          fill_color "0C2D83"
          move_down 2
          text 'Commonwealth of Massachusetts', size: 20, align: :center, inline_format: true
        end
        reset_fill_color
        font("#{Rails.root}/public/fonts/TIMES.TTF") do
          move_down 2
          text 'BOARD OF REGISTRATION OF REAL ESTATE BROKERS AND SALESPERSONS', size: 9.5, align: :center
          fill_color "0563C1"
          move_down 2
          table([["<link href='http://www.mass.gov/dpl/boards/re'>www.mass.gov/dpl/boards/re</link>"]] , position: :center, cell_style: {inline_format: true, borders: [:bottom], padding: [0,0,0,0], border_color: "0563C1"})
          reset_fill_color
          move_down 5
          text 'MASSACHUSETTS MANDATORY REAL ESTATE LICENSEE-CONSUMER RELATIONSHIP DISCLOSURE', size: 9.5, align: :center
          move_down 2
          text '<u>THIS IS NOT A CONTRACT</u>', size: 10.5, align: :center, inline_format: true
        end
      end

      font("#{Rails.root}/public/fonts/TIMES.TTF") do
        move_down 2
        table([["This disclosure is provided to you, the consumer, by the real estate licensee listed in this disclosure."]] , position: :center, cell_style: {inline_format: true, padding: [3,3,3,3], size: 9}, row_colors: ["D9D9D9"], width: bounds.width)
      end

    end

    def reset_fill_color
      fill_color "000000"
    end
  end
end

