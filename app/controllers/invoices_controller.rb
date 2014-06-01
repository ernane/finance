class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def sender_invoice
    @invoice = Invoice.find(params[:id])

    InvoicesMailer.send_invoice({
        email:         @invoice.customer.email,
        invoice_path:  @invoice.invoice_path,
        number:        @invoice.number,
        due_date:      @invoice.due_date
      }).deliver

     redirect_to root_url, notice: "Delivered newsletter."
  end
end
