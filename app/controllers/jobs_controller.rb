class JobsController < ApplicationController
  before_filter :signed_in_employer, only: [:create, :destroy]
  before_filter :correct_employer, only: :destroy

  def create
  	@job=current_employer.jobs.build(params[:job])
  	if @job.save
  	  flash[:success]="Job created!"
  	  redirect_to root_path
  	else
      @feed_jobs=[]
  	  render 'static_pages/home'
  	end
  end

  def destroy
  	@job.destroy
    redirect_back_or root_path
  end

  private

    def correct_employer
      @job=current_employer.jobs.find_by_id(params[:id])
      redirect_to root_path if @job.nil?
    end
end