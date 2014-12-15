class SessionsController < ApplicationController

  def new
  end

  def create
  	employee=Employee.find_by_email(params[:session][:email])
  	if employee && employee.authenticate(params[:session][:password])
  	  # Sign the employee in and redirect to the employee's show page.
  	  sign_in employee
  	  redirect_to employee
  	else
  	  flash.now[:danger]='Invalid email/password combination' # Not quite right!
  	  render 'new'
  	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
