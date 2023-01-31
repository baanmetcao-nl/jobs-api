# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :load_and_authorize_job!, except: %i[create index]
  before_action :load_and_authorize_jobs!, only: :index

  def index; end

  def create
    @job = Job.new(job_params.except(:benefits))
    @job.build_benefits(benefits_params)
    @job.employer = current_user&.employer

    authorize! @job

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

  def job_params
    params.require(:job)
          .permit(:position,
                  :description,
                  :experience,
                  :expires_at,
                  benefits: %i[min_salary max_salary vacation_days pension])
  end

  def benefits_params = job_params.fetch(:benefits)

  def load_and_authorize_job!
    @job = Job.find(params[:id])

    authorize! @job
  end

  def load_and_authorize_jobs!
    @jobs = Job.includes(:benefits).includes(employer: :company).all

    authorize! @jobs
  end
end
