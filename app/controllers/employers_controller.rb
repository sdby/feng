class EmployersController < ApplicationController
  
  def show
  	@employer=Employer.find(params[:id])
  end

  def new
  	@employer=Employer.new
  end

  def create
  	@employer=Employer.new(params[:employer])
  	if @employer.save
  	  # Handle a succesful save.
      flash[:success]="Welcome to the talent highland!"
      redirect_to @employer
  	else
  	  render 'new'
  	end
  end
end