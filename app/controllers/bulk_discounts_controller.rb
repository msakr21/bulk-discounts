class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    BulkDiscount.create!(amount: params[:discount_amount], threshold: params[:quantity_threshold], merchant_id: params[:merchant_id])

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
    @merhcant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def update
  end
end