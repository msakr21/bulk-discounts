class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    discount = BulkDiscount.create!(amount: params[:discount_amount], threshold: params[:quantity_threshold], merchant_id: params[:merchant_id])

    discount.update_matching_invoice_items

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  def destroy
    BulkDiscount.destroy(params[:id])

    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    discount.update!(amount: params[:discount_amount], threshold: params[:quantity_threshold])
    redirect_to(merchant_bulk_discount_path(params[:merchant_id], params[:id]))
  end
end