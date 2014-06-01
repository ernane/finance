include ActionView::Helpers::NumberHelper

class InvoicePdf < Prawn::Document
  def initialize(invoice)
    super(top_margin: 70)
    @invoice = invoice

    invoice_title
    invoice_customer_info
    invoice_items
    invoice_subtotal
    invoice_total
    invoice_footer
    invoice_path
  end

private

  def invoice_title
    text "Fatura ##{@invoice.number}", size: 30, style: :bold
  end

  def invoice_customer_info
    move_down 20
    text "Informações Gerais da Fatura", size: 18, style: :bold

    text "Nome:     #{@invoice.customer.name}",  size: 10
    text "Telefone: #{@invoice.customer.phone}", size: 10
    text "E-mail:   #{@invoice.customer.email}", size: 10

    move_down 5
    text "Data de Emissão :   #{I18n.l(@invoice.issue_date)}",  size: 10, style: :bold
    text "Data de Vencimento: #{I18n.l(@invoice.due_date)}",    size: 10, style: :bold
  end

  def invoice_items
    move_down 20
    table invoice_item_rows do
      row(0).font_style   = :bold
      columns(0..0).align = :center
      columns(2..3).align = :center
      self.row_colors     = ["DDDDDD", "FFFFFF"]
      self.header         = true
      self.position       = :center
      self.column_widths  = [40, 300, 100, 100]
    end
  end

  def invoice_item_rows
    [["Qtd", "Descrição", "Valor Unitário", "Valor Total"]] +
    @invoice.invoice_items.map do |item|
      [item.quantity, item.description, price(item.unitary_cost), price(item.amount)]
    end
  end

  def invoice_subtotal
    move_down 15
    text "Total da Fatura: #{price(@invoice.subtotal)}", size: 16, style: :bold
  end

  def invoice_total
    move_down 200
    stroke_horizontal_rule
    pad(5) { text "Total da Dívida: #{price(@invoice.total)}", size: 18, style: :bold }
  end

  def invoice_footer
    draw_text "Gerado em #{I18n.l(Time.now, format: :long)}", at: [0, 0], style: :italic, size: 6
  end

  def invoice_path
    render_file @invoice.invoice_path
  end

  def price(number)
    number_to_currency(number)
  end

  # InvoicePdf.new(Invoice.last)
end
