class SessionsController < ApplicationController
  before_action :require_login, only: :logout

  def create
    applicant = Applicant.find_by email: email
    if applicant && applicant.phone == phone
      log_in applicant
      flash[:success] = "Welcome back"
      redirect_to edit_applicant_path(applicant)
    else
      @errors = "Invalid email and/or phone"
      render "new"
    end
  end

  def new
  end

  def logout
    log_out
    redirect_to root_path
  end

  private

  def email
    @email ||= params[:email]
  end

  def phone
    @phone ||= params[:phone]
  end
end
