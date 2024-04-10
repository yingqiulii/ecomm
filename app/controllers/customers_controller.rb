class CustomersController < ApplicationController
def new
  @customer=Customer.new
end

def create
  @customer=Customer.new(params.require(:customer)
  .permit(:email,:password,:password_confirmation))
  if @customer.save
    flash[:notice]="success"
    redirect_to root_path
  else
    render action: :new
  end
end
end