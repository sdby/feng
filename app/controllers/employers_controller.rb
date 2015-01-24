class EmployersController < ApplicationController

  before_filter :signed_in_employer, only: [:index, :edit, :update, :destroy]
  before_filter :correct_employer, only: [:edit, :update]
  before_filter :admin_employer, only: :destroy
  
  def show
  	@employer=Employer.find(params[:id])
    @jobs=@employer.jobs.paginate(page: params[:page])
  end

  def new
  	@employer=Employer.new
  end

  def create
  	@employer=Employer.new(params[:employer])
  	if @employer.save
      sign_in @employer
      flash[:success]="Welcome to the talent highland!"
      redirect_to @employer
  	else
  	  render 'new'
  	end
  end

  def edit
  end

  def update
    if @employer.update_attributes(params[:employer])
      flash[:success]="Profile updated"
      sign_in @employer
      redirect_to @employer
    else
      render 'edit'
    end
  end

  def index
    @employers=Employer.paginate(page: params[:page])
  end

  def destroy
    Employer.find(params[:id]).destroy
    flash[:success]="Employer destroyed."
    redirect_to employers_path
  end

  private

    # def signed_in_employer
    #   unless employer_signed_in?
    #     store_location
    #     redirect_to signin_path, notice: "Please sign in."
    #   end
    # end

    def correct_employer
      @employer=Employer.find(params[:id])
      redirect_to(root_path) unless current_employer?(@employer)
    end

    def admin_employer
      redirect_to(root_path) unless current_employer.admin?
    end
end
