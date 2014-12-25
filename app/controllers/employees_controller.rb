class EmployeesController < ApplicationController

  before_filter :signed_in_employee, only: [:index, :edit, :update, :destroy]
  before_filter :correct_employee, only: [:edit, :update]
  before_filter :admin_employee, only: :destroy

  def show
  	@employee=Employee.find(params[:id])
  end
  
  def new
  	@employee=Employee.new
  end

  def create
  	@employee=Employee.new(params[:employee])
  	if @employee.save
      sign_in @employee
      flash[:success]="Welcome to the talent highland"
      redirect_to @employee
  	else
  	  render 'new'
  	end
  end

  def edit
    # @employee=Employee.find(params[:id])
  end

  def update
    # @employee=Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:success]="Profile updated"
      sign_in @employee
      redirect_to @employee
    else
      render 'edit'
    end
  end

  def index
    @employees=Employee.paginate(page: params[:page])
  end

  def destroy
    Employee.find(params[:id]).destroy
    flash[:success]="Employee destroyed."
    redirect_to employees_path
  end

  private

    def signed_in_employee
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in." 
      end
    end

    def correct_employee
      @employee=Employee.find(params[:id])
      redirect_to(root_path) unless current_employee?(@employee)
    end

    def admin_employee
      redirect_to(root_path) unless current_employee.admin?
    end
end
