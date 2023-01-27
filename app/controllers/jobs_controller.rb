# frozen_string_literal: true

class JobsController < ApplicationController
  def index
    @jobs = Job.includes(:benefits).includes(employer: :company).all
  end
end
