class StaticPagesController < ApplicationController
  def home
  	if employer_signed_in?
  	  @job=current_employer.jobs.build
  	  @feed_jobs=current_employer.feed.paginate(page: params[:page])
  	end
  end

  def help
  end

  def about
  end

  def contact
  end
end
