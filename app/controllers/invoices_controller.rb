class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice)
        send_data pdf.render, filename: "invoice_#{@invoice.number}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(invoice_params)
      flash[:notice] = "Invoice has been updated."
      redirect_to @invoice
    else
      flash[:alert] = "Invoice has not been updated."
      render action: "edit"
    end
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
