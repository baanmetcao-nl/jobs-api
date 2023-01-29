# frozen_string_literal: true

class JobsController < ApplicationController
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
    @job = Job.find(params[:id])

    return head :not_found if @job.nil?

    if @job.benefits.update(benefits_params)
      render 'jobs/update'
    else
      render_unprocessable_entity
    end
  end

  def publish; end

  def unpublish; end

  def destroy; end

  private

  def job_params
    params.require(:job)
          .permit(:position,
                  :description,
                  :experience,
                  benefits: %i[min_salary max_salary vacation_days pension])
  end

  def benefits_params
    job_params.fetch(:benefits)
  end
end
