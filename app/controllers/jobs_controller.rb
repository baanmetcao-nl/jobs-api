# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_job, only: %i[update publish unpublish destroy]

  def index
    @jobs = Job.includes(:benefits).includes(employer: :company).all
  end

  def create
    @job = Job.new(*job_params, employer_id: current_user.employer_id)

    if @job.save
      render_no_content
    else
      render_unprocessable_entity
    end
  end

  def update
    return render_not_found if @job.nil?

    if @job.benefits.update(benefits_params)
      render 'jobs/update'
    else
      render_unprocessable_entity
    end
  end

  def publish
    return render_not_found if @job.nil?

    if @job.update(published_at: Time.zone.now)
      render 'jobs/update'
    else
      render_unprocessable_entity
    end
  end

  def unpublish
    return render_not_found if @job.nil?

    if @job.update(published_at: nil)
      render 'jobs/update'
    else
      render_unprocessable_entity
    end
  end

  def destroy
    return render_not_found if @job.nil?

    if @job.destroy
      render_no_content
    else
      render_internal_server_error

    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job)
          .permit(:position,
                  :description,
                  :experience,
                  benefits: %i[min_salary max_salary vacation_days pension])
  end

  def benefits_params = job_params.fetch(:benefits)
end
