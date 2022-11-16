class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @total_revenue = (@invoice.total_revenue(params[:merchant_id]).to_f.round(2))/100
    @discounted_total_revenue = @total_revenue - (@invoice.discount_from_total_revenue(params[:merchant_id]).to_f.round(2))/100
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update!(status: params[:status])
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end
