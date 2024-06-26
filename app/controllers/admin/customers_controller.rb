class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_search
  before_action :set_customer, only: [:show, :edit, :update]
  def index
    @customers = Customer.all.order(params[:sort]).page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_search
    @q = Customer.ransack(params[:q])
    @customers = @q.result.order(params[:sort]).page(params[:page]).per(10)
  end

  def customer_params
    params.require(:customer).permit(:name, :introduction, :email, :is_active)
  end
end
