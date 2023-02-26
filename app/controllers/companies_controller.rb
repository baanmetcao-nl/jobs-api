# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :authorize_account!

  def create 
    company = Company.create!(create_params)
    employer = Employer.create!(company_id: company.id, user_id: current_user.id)

    head :no_content
  end

  def update 
    current_user.company.update!(update_params)

    head :no_content
  end

  private 

  def create_params 
    require(:company)
        .permit(:name, :description, :logo, :website_url)
  end

  def update_params 
    require(:company)
        .permit(:name, :description, :logo, :website_url)
  end
end
