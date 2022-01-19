class BulkDiscountsController < ApplicationController 
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end
end