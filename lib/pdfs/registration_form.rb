module Pdfs
  class RegistrationForm < Prawn::Document

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
      body
      form
      signatures
      types_of_agency_representation
      footer
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
        checkbox(@data[:real_estate_licensee_type].to_s == "1", 90, cursor_y)
        move_cursor_to cursor_y
        draw_text("Seller's agent", at: [105, cursor - 8], size: 9)

        move_cursor_to cursor_y
        checkbox(@data[:real_estate_licensee_type].to_s == "2", 180, cursor_y)
        move_cursor_to cursor_y
        draw_text("Buyer's agent", at: [195, cursor - 8], size: 9)

        move_cursor_to cursor_y
        checkbox(@data[:real_estate_licensee_type].to_s == "3", 270, cursor_y)
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
        checkbox(! @data[:is_designated_agency], 75, cursor_y)
        move_cursor_to cursor_y
        draw_text("Non-Designated Agency", at: [90, cursor - 8], size: 8)

        line [75, cursor_y - 12], [300, cursor_y - 12]

        line [315, cursor_y - 12], [540, cursor_y - 12]

        move_cursor_to cursor_y
        checkbox(@data[:is_designated_agency], 315, cursor_y)
        move_cursor_to cursor_y
        draw_text("Designated Agency", at: [330, cursor - 8], size: 8)

        block_cursor_y = cursor - 16

        text_box("The real estate firm or business listed below and all other affiliated agents are also working as the agent of the", size: 9.5, at: [75, block_cursor_y], width: 225)

      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        cursor_y = cursor - 36
        checkbox(! @data[:is_designated_agency] && @data[:designated_agency_type].to_s == '1', 110, cursor_y)
        draw_text("Seller", at: [120, cursor_y - 8], size: 8)

        checkbox(! @data[:is_designated_agency] && @data[:designated_agency_type].to_s == '2', 150, cursor_y)
        draw_text("Buyer", at: [160, cursor_y - 8], size: 8)
      end

      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        text_box("Only the licensee named herein represents the", size: 9.5, at: [315, block_cursor_y], width: 225)
      end

      cursor_y = cursor + 18

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(@data[:is_designated_agency] && @data[:designated_agency_type].to_s == '1', 315, cursor_y)
        draw_text("Seller", at: [325, cursor_y - 8], size: 8)

        checkbox(@data[:is_designated_agency] && @data[:designated_agency_type].to_s == '2', 365, cursor_y)
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

        if @data[:printed_name_of_real_estate_licensee].length < 50
          @data[:printed_name_of_real_estate_licensee] = @data[:printed_name_of_real_estate_licensee].ljust(50)
        else
          @data[:printed_name_of_real_estate_licensee] = @data[:printed_name_of_real_estate_licensee][0, 50] + "..."
        end

        table([["#{@data[:printed_name_of_real_estate_licensee]} #{@data[:license_number]}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Printed Name of Real Estate Licensee          License #', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["#{Time.now.strftime("%Y-%m-%d")}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
        draw_text('Today’s Date', at: [470, cursor - 8], size:  7)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(@data[:printed_name_of_real_estate_licensee_type].to_s == "1", 360, cursor_y)
        draw_text("Broker", at: [370, cursor_y - 8], size: 7)

        checkbox(@data[:printed_name_of_real_estate_licensee_type].to_s == "2", 405, cursor_y)
        draw_text("Salesperson", at: [415, cursor_y - 8], size: 7)
      end

      #------------------------------------------------------------------------------------------------

      # Secound Block ---------------------------------------------------------------------------------

      move_down 20

      cursor_y = 0

      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        move_down 20

        if @data[:name_real_estate_brokerage_firm].length < 50
          @data[:name_real_estate_brokerage_firm] = @data[:name_real_estate_brokerage_firm].ljust(50)
        else
          @data[:name_real_estate_brokerage_firm] = @data[:name_real_estate_brokerage_firm][0, 50] + "..."
        end

        table([["#{@data[:name_real_estate_brokerage_firm]}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 0, :width => 155)
        draw_text("Name Real Estate Brokerage Firm", at: [5, cursor - 8], size: 7)

        move_up 12

        cursor_y = cursor


        table([["#{@data[:brokerage_firm_real_estate_license_number]}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
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

        if @data[:printed_name_of_consumer1].length < 50
          @data[:printed_name_of_consumer1] = @data[:printed_name_of_consumer1].ljust(50)
        else
          @data[:printed_name_of_consumer1] = @data[:printed_name_of_consumer1][0, 50] + "..."
        end

        table([["#{@data[:printed_name_of_consumer1]}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Printed Name of Consumer', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["#{Time.now.strftime("%Y-%m-%d")}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
        draw_text('Today’s Date', at: [470, cursor - 8], size:  7)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(@data[:customer_type1].to_s == "1", 360, cursor_y)
        draw_text("Buyer", at: [370, cursor_y - 8], size: 7)

        checkbox(@data[:customer_type1].to_s == "2", 405, cursor_y)
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

        if @data[:printed_name_of_consumer2].length < 50
          @data[:printed_name_of_consumer2] = @data[:printed_name_of_consumer2].ljust(50)
        else
          @data[:printed_name_of_consumer2] = @data[:printed_name_of_consumer2][0, 50] + "..."
        end

        table([["#{@data[:printed_name_of_consumer2]}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5}, :position => 160, :width => 185)
        draw_text('Printed Name of Consumer', at: [165, cursor - 8], size:  7)

        move_up 12

        table([["#{Time.now.strftime("%Y-%m-%d")}"]] , cell_style: {inline_format: true, borders: [:bottom], padding: [2,2,2,2], border_color: "000000", size: 7.5, align: :center}, :position => 470, :width => 70)
        draw_text('Today’s Date', at: [470, cursor - 8], size:  7)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        checkbox(@data[:customer_type2].to_s == "1", 360, cursor_y)
        draw_text("Buyer", at: [370, cursor_y - 8], size: 7)

        checkbox(@data[:customer_type2].to_s == "2", 405, cursor_y)
        draw_text("Seller", at: [415, cursor_y - 8], size: 7)
      end

      #------------------------------------------------------------------------------------------------

      move_down 40

      checkbox(@data[:consumer_declines_to_sign_this_notice], 320, cursor - 14)
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

    def types_of_agency_representation

      # add new page
      start_new_page

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        text 'TYPES OF AGENCY REPRESENTATION', size: 9.5, align: :center, inline_format: true
      end

      move_down 10

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        table([["SELLER'S AGENT"]] , cell_style: {inline_format: true, borders: [:top, :left, :right], padding: [2,2,2,2], border_color: "000000", size: 9, align: :center}, :position => 0, :width => bounds.width)
      end
      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        table([["A seller can engage the services of a real estate licensee to act as the seller’s agent in the sale of the seller’s property. This meansthat the real estate agent represents the seller, who is a client. The agent owes the seller client undivided loyalty, reasonable care, disclosure, obedience to lawful instruction, confidentiality and accounting. The agent must put the seller's interests first and attempt to negotiate price and terms acceptable to their seller client. The seller may authorize sub-agents to represent him/her in marketing its property to buyers, however the seller should be aware that wrongful action by the real estate agent or sub-agents may subject the seller to legal liability for those wrongful actions."]] , cell_style: {inline_format: true, borders: [:bottom, :left, :right], border_color: "000000", size: 9, align: :justify}, :position => 0, :width => bounds.width)
      end


      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        table([["BUYER'S AGENT"]] , cell_style: {inline_format: true, borders: [:top, :left, :right], padding: [2,2,2,2], border_color: "000000", size: 9, align: :center}, :position => 0, :width => bounds.width)
      end
      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        table([["A buyer can engage the services of a real estate licensee to act as the buyer’s agent in the purchase of a property. This means that the real estate agent represents the buyer, who is a client. The agent owes the buyer client undivided loyalty, reasonable care, disclosure, obedience to lawful instruction, confidentiality and accounting. The agent must put the buyer's interests first and attempt to negotiate price and terms acceptable to their buyer client. The buyer may also authorize sub-agents to represent him/her in purchasing property, however the buyer should be aware that wrongful action by the real estate agent or sub-agents may subject the buyer to legal liability for those wrongful actions."]] , cell_style: {inline_format: true, borders: [:bottom, :left, :right], border_color: "000000", size: 9, align: :justify}, :position => 0, :width => bounds.width)
      end


      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        table([["(NON-AGENT) FACILITATOR"]] , cell_style: {inline_format: true, borders: [:top, :left, :right], padding: [2,2,2,2], border_color: "000000", size: 9, align: :center}, :position => 0, :width => bounds.width)
      end
      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        table([["When a real estate licensee works as a facilitator that licensee assists the seller and/or buyer in reaching an agreement but does not represent either the seller or buyer in the transaction. The facilitator and the broker with whom the facilitator is affiliated, owe the seller and buyer a duty to present all real property honestly and accurately by disclosing known material defects and owe a duty to account for funds. Unless otherwise agreed, the facilitator has no duty to keep information received from a seller or buyer confidential. Should the seller and/or buyer expressly agree, a facilitator relationship can be changed to a seller or buyer client relationship with the written agreement of the person so represented."]] , cell_style: {inline_format: true, borders: [:bottom, :left, :right], border_color: "000000", size: 9, align: :justify}, :position => 0, :width => bounds.width)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        table([["DESIGNATED SELLER'S AND BUYER'S AGENT"]] , cell_style: {inline_format: true, borders: [:top, :left, :right], padding: [2,2,2,2], border_color: "000000", size: 9, align: :center}, :position => 0, :width => bounds.width)
      end
      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        table([["A real estate licensee can be designated by another real estate licensee (the appointing or designating agent) to represent a buyer or seller, provided the buyer or seller expressly agrees to such designation. The real estate licensee once so designated is then the agent for that buyer or seller who becomes the agent’s client. The designated agent owes the buyer client or seller client, undivided loyalty, reasonable care, disclosure, obedience to lawful instruction, confidentiality and accounting. The agent must put their client's interests first, and attempt to negotiate price and terms acceptable to their client. No other licensees affiliated with the same firm represent the client unless otherwise agreed upon by the client. In situations where the appointing agent designates another agent to represent the seller and an agent to represent the buyer in the same transaction, then the appointing agent becomes a dual agent. Consequently, a dual agent cannot fully satisfy the duties of loyalty, full disclosure, obedience to lawful instructions, which is required of a seller or buyer agent. Only your designated agent represents your interests. Written consent for designated agency must be provided before a potential transaction is identified, but in any event, no later than prior to the execution of a written agreement for purchase or sale of residential property. The consent must contain the information provided for in the regulations of the Massachusetts Board of Registration of Real Estate Brokers and Salespeople (Board). A sample consent to designated agency is available at the Board's website at  <color rgb='0563C1'><link anchor='http://www.mass.gov/dpl/re'>www.mass.gov/dpl/re</link></color>."]] , cell_style: {inline_format: true, borders: [:bottom, :left, :right], border_color: "000000", size: 9, align: :justify}, :position => 0, :width => bounds.width)
      end

      font("#{Rails.root}/public/fonts/ARIALB.TTF") do
        table([["DUAL AGENT"]] , cell_style: {inline_format: true, borders: [:top, :left, :right], padding: [2,2,2,2], border_color: "000000", size: 9, align: :center}, :position => 0, :width => bounds.width)
      end
      font("#{Rails.root}/public/fonts/ARIAL.TTF") do
        table([["A real estate licensee may act as a dual agent representing both the seller and the buyer in a transaction but only with the express and informed written consent of both the seller and the buyer. A dual agent shall be neutral with regard to any conflicting interest of the seller and buyer. Consequently, a dual agent cannot satisfy fully the duties of loyalty, full disclosure, obedience to lawful instructions, which is required of a seller or buyer agent. A dual agent does, however, still owe a duty of confidentiality of material information and accounting for funds. Written consent for dual agency must be provided before a potential transaction is identified, but in any event, no later than prior to the execution of a written agreement for purchase or sale of residential property. The consent must contain the information provided for in the regulations of the Massachusetts Board of Registration of Real Estate Brokers and Salespeople (Board). A sample consent to dual agency is available at the Board's website at  <color rgb='0563C1'><link anchor='http://www.mass.gov/dpl/re'>www.mass.gov/dpl/re</link></color>."]] , cell_style: {inline_format: true, borders: [:bottom, :left, :right], border_color: "000000", size: 9, align: :justify}, :position => 0, :width => bounds.width)
      end
    end

    def footer
      font("#{Rails.root}/public/fonts/ARIALI.TTF") do
        number_pages "Last Revised: January 24, 2017", {:at => [bounds.left, 0], :size => 10}
      end
    end

    private

    def reset_fill_color
      fill_color "000000"
    end
  end
end

