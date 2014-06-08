class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      flash[:notice] = "Invoice has been created."
      redirect_to @invoice
    else
      flash[:alert] = "Invoice has not been created."
      render "new"
    end
  end

  def sender_invoice
    @invoice = Invoice.find(params[:id])

    InvoicesMailer.send_invoice({
      email:        @invoice.customer.email,
      invoice_path: @invoice.invoice_path,
      number:       @invoice.number,
      due_date:     @invoice.due_date
      }).deliver

    redirect_to root_url, notice: "Delivered newsletter."
  end

  private

  def invoice_params
    params.require(:invoice).permit(:customer_id, :due_date, :issue_date, invoice_items_attributes: [ :id, :description, :quantity, :unitary_cost, :_destroy ])
  end
end
