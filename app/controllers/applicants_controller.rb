class ApplicantsController < ApplicationController
  def create
    @applicant = Applicant.new permitted
    if @applicant.save

    else
      @errors = stringify_single_error @applicant.errors
      render "new"
    end
  end

  def new
    @applicant = Applicant.new
  end

  private

  def permitted_params
    %i(email first_name last_name phone phone_type region)
  end
end
