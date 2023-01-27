# frozen_string_literal: true

module Employer
  class UserController < ApplicationController
    def destroy
      user = User.find(params[:id])
      if user.nil?
        head :not_found
      elsif user.destroy
        head :no_content
      else
        head :internal_server_error
      end
    end
  end
end
