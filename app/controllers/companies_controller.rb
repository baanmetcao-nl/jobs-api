# frozen_string_literal: true

class CompaniesController < ApplicationController
  def create
    company = Company.new(create_params)
    authorize! company
    company.save!
    Employer.create!(company_id: company.id, user_id: current_user.id)

    head :no_content
  end

  def update
    company = current_user.company
    authorize! company

    company.update!(update_params)

    head :no_content
  end

  private

  def create_params
    params.require(:company).permit(:name, :website_url, :logo, :description, :location)
  end

  def update_params
    params.require(:company).permit(:name, :description, :logo, :website_url, :location)
  end
end
