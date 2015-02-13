class ApplicationsController < ApplicationController

  before_filter :signed_in_employee

  def create
  	@job=Job.find(params[:application][:job_id])
  	current_employee.apply!(@job)
    respond_to do |format|
      format.html {redirect_to @job}
      format.js
    end
  end

  def destroy
  	@job=Application.find(params[:id]).job
  	current_employee.unapply!(@job)
    respond_to do |format|
      format.html {redirect_to @job}
      format.js
    end
  end
end
