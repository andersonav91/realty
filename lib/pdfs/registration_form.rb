module Pdfs
  class RegistrationForm < Prawn::Document
    def initialize()
      super(top_margin: 30, right_margin: 30, left_margin: 30)

      font_families.update("Arial" => {
          :normal => "#{Rails.root}/public/fonts/ARIAL.TTF",
          :italic => "#{Rails.root}/public/fonts/ARIALI.TTF",
          :bold => "#{Rails.root}/public/fonts/ARIALB.TTF"
      })
      title
      body
      form
      signatures
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

    def body
      font("Arial") do
        move_down 10
        text '<b>THE TIME WHEN THE REAL ESTATE LICENSEE MUST PROVIDE THIS NOTICE TO THE CONSUMER:</b>', size: 9.5, align: :left, inline_format: true

        move_down 5
        text 'All real estate licensees must present this form to you at the first personal meeting with you to discuss a specific property. In the event this relationship changes, an additional disclosure must be provided and completed at that time.', size: 9, align: :left, inline_format: true

        move_down 5
        text '<b>CONSUMER INFORMATION AND RESPONSIBILITY:</b>', size: 9.5, align: :left, inline_format: true

        move_down 5
        text "If you are a buyer or seller, you can engage a real estate licensee to provide advice, assistance and representation to you as your agent. The real estate licensee can represent you as the seller (Seller's Agent) or represent you as the buyer (Buyer's Agent), or can assist you as a Facilitator.", size: 9, align: :left, inline_format: true

        move_down 5
        text "All real estate licensees, regardless of the working relationship with a consumer must, by law, present properties honestly and accurately, and disclose known material defects in the real estate.", size: 9, align: :left, inline_format: true

        move_down 5
        text "The duties of a real estate licensee do not relieve consumers of the responsibility to protect their own interests. If you need advice for legal, tax, insurance, zoning, permitted use, or land survey matters, it is your responsibility to consult a professional in those areas. Real estate licensees do not and cannot perform home, lead paint, or insect inspections, nor do they perform septic system, wetlands or environmental evaluations.", size: 9, align: :left, inline_format: true

        move_down 5
        text "Do not assume that a real estate licensee works solely for you unless you have an agreement for that relationship.", size: 9, align: :left, inline_format: true

        move_down 5
        table([["For more detailed definitions and descriptions about real estate relationships, please see page 2 of this disclosure."]] , position: :center, cell_style: {inline_format: true, padding: [3,3,3,3], size: 9}, row_colors: ["D9D9D9"], width: bounds.width)
      end
    end

    def form
      font("Arial") do
        move_down 10
        text '<b>THE SELLER OR BUYER RECEIVING THIS DISCLOSURE IS HEREBY ADVISED THAT THE REAL ESTATE LICENSEE NAMED BELOW IS WORKING AS A:</b>', size: 10, align: :left, inline_format: true

        move_down 5
        cursor_y = cursor
        draw_text('Check one:', at: [0, cursor - 8], size: 9)

        move_cursor_to cursor_y
        checkbox(true, 90, cursor_y)
        move_cursor_to cursor_y
        draw_text("Seller's agent", at: [105, cursor - 8], size: 9)

        move_cursor_to cursor_y
        checkbox(true, 180, cursor_y)
        move_cursor_to cursor_y
        draw_text("Buyer's agent", at: [195, cursor - 8], size: 9)

        move_cursor_to cursor_y
        checkbox(true, 270, cursor_y)
        move_cursor_to cursor_y
        draw_text("Facilitator", at: [285, cursor - 8], size: 9)

        move_down 18
      end

      font("#{Rails.root}/public/fonts/ARIALBI.TTF") do
        text 'If seller’s or buyer’s agent is checked above, the real estate licensee must complete the following section:', size: 10, align: :left, inline_format: true
      end

      block_cursor_y = 0

      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        move_down 10
        cursor_y = cursor
        draw_text('Check one:', at: [0, cursor - 8], size: 9)

        move_cursor_to cursor_y
        checkbox(true, 75, cursor_y)
        move_cursor_to cursor_y
        draw_text("Non-Designated Agency", at: [90, cursor - 8], size: 8)

        line [75, cursor_y - 12], [300, cursor_y - 12]

        line [315, cursor_y - 12], [540, cursor_y - 12]

        move_cursor_to cursor_y
        checkbox(true, 315, cursor_y)
        move_cursor_to cursor_y
        draw_text("Designated Agency", at: [330, cursor - 8], size: 8)

        block_cursor_y = cursor - 16

        text_box("The real estate firm or business listed below and all other affiliated agents are also working as the agent of the", size: 9.5, at: [75, block_cursor_y], width: 225)

      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        cursor_y = cursor - 36
        checkbox(true, 110, cursor_y)
        draw_text("Seller", at: [120, cursor_y - 8], size: 8)

        checkbox(true, 150, cursor_y)
        draw_text("Buyer", at: [160, cursor_y - 8], size: 8)
      end

      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        text_box("Only the licensee named herein represents the", size: 9.5, at: [315, block_cursor_y], width: 225)
      end

      cursor_y = cursor + 18

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(true, 315, cursor_y)
        draw_text("Seller", at: [325, cursor_y - 8], size: 8)

        checkbox(true, 365, cursor_y)
        draw_text("Buyer", at: [375, cursor_y - 8], size: 8)
      end

      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        text_box("(designated seller agency or ", size: 9.5, at: [410, cursor_y], width: 150)
        text_box("designated buyer agency). In this situation any other agents affiliated with the firm or business listed below do not represent you and may represent another party in your real estate transaction.", size: 9.5, at: [315, cursor_y - 11], width: 225)
      end
    end

    def signatures
      # First Block ---------------------------------------------------------------------------------

      move_down 50

      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        text "By signing below, I, the real estate licensee, acknowledge that this disclosure has been provided to the consumer named herein:", size: 9, align: :left, inline_format: true
      end

      cursor_y = 0

      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        move_down 20

        table([["<color rgb='FFFFFF'>signature</color>"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 0, :width => 155)
        draw_text("Signature of Real Estate Licensee", at: [5, cursor - 8], size: 7)

        move_up 12

        cursor_y = cursor

        table([["Some Text"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Printed Name of Real Estate Licensee          License #', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["#{Time.now.strftime("%Y-%m-%d")}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
        draw_text('Today’s Date', at: [470, cursor - 8], size:  7)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(true, 360, cursor_y)
        draw_text("Broker", at: [370, cursor_y - 8], size: 7)

        checkbox(true, 405, cursor_y)
        draw_text("Salesperson", at: [415, cursor_y - 8], size: 7)
      end

      #------------------------------------------------------------------------------------------------

      # Secound Block ---------------------------------------------------------------------------------

      move_down 20

      cursor_y = 0

      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        move_down 20

        table([["Some Text"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 0, :width => 155)
        draw_text("Name Real Estate Brokerage Firm", at: [5, cursor - 8], size: 7)

        move_up 12

        cursor_y = cursor

        table([["Some Text"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Brokerage Firm Real Estate License #', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["<color rgb='FFFFFF'>date</color>"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
      end

      #------------------------------------------------------------------------------------------------

      # Third Block ------------------------------------------------------------------------------------

      move_down 20

      cursor_y = 0

      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        move_down 20

        table([["<color rgb='FFFFFF'>signature</color>"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 0, :width => 155)
        draw_text("Signature of Consumer", at: [5, cursor - 8], size: 7)

        move_up 12

        cursor_y = cursor

        table([["Some Text"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Printed Name of Consumer', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["#{Time.now.strftime("%Y-%m-%d")}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
        draw_text('Today’s Date', at: [470, cursor - 8], size:  7)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(true, 360, cursor_y)
        draw_text("Buyer", at: [370, cursor_y - 8], size: 7)

        checkbox(true, 405, cursor_y)
        draw_text("Seller", at: [415, cursor_y - 8], size: 7)
      end

      #------------------------------------------------------------------------------------------------

      # Fourth Block ------------------------------------------------------------------------------------

      move_down 20

      cursor_y = 0

      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        move_down 20

        table([["<color rgb='FFFFFF'>signature</color>"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 0, :width => 155)
        draw_text("Signature of Consumer", at: [5, cursor - 8], size: 7)

        move_up 12

        cursor_y = cursor

        table([["Some Text"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Printed Name of Consumer', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["#{Time.now.strftime("%Y-%m-%d")}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
        draw_text('Today’s Date', at: [470, cursor - 8], size:  7)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(true, 360, cursor_y)
        draw_text("Buyer", at: [370, cursor_y - 8], size: 7)

        checkbox(true, 405, cursor_y)
        draw_text("Seller", at: [415, cursor_y - 8], size: 7)
      end

      #------------------------------------------------------------------------------------------------

      move_down 40

      checkbox(true, 320, cursor - 14)
      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        draw_text("Check here if the consumer declines to sign this notice", at: [330, cursor], size: 9)
      end
    end

    def checkbox(flag, x_position = 7, y_position = cursor - 2)
      bounding_box([x_position, y_position], width: 8, height: 8) do
        stroke_bounds
        text("<b>X</b>", align: :center, valign: :center, size: 7, inline_format: true) if flag
      end
    end

    def reset_fill_color
      fill_color "000000"
    end
  end
end

