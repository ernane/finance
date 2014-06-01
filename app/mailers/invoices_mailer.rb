class InvoicesMailer < ActionMailer::Base
  default from: "Ernane Sena <ernane.sena@gmail.com>"

  def send_invoice(options)
    @options = options

    attachments["invoice-#{options[:number]}.pdf"] = File.read(options[:invoice_path])

    mail subject: "Fatura - Ernane Sena", to: options[:email], cc: "ernane.sena@gmail.com" do |format|
      format.text
      format.html
    end
  end
end

# invoice = Invoice.last
# options = { email: invoice.customer.email, invoice_path: invoice.invoice_path, number: invoice.number, due_date: invoice.due_date }
# InvoicesMailer.send_invoice(options).deliver
