class ApplicantsController < ApplicationController
  before_action :require_login,
                only: %i(background background_authorize confirmation edit)
  before_action :check_background_authorization,
                only: %i(background background_authorize)

  def background
  end

  def background_authorize
    current_applicant.update_next_workflow_state
    redirect_to confirmation_applicants_path
  end

  def confirmation
  end

  def create
    @applicant = Applicant.new permitted
    if @applicant.save
      log_in @applicant
      redirect_to background_applicants_path
    else
      @errors = stringify_single_error @applicant.errors
      render "new"
    end
  end

  def edit
    @applicant = current_applicant
  end

  def new
    @applicant = Applicant.new
  end

  def update
    @applicant = current_applicant
    if @applicant.update permitted
      log_in @applicant
      flash[:success] = "Update successful"
      redirect_to edit_applicant_path(current_applicant)
    else
      @errors = stringify_single_error @applicant.errors
      render "edit"
    end
  end

  private

  def check_background_authorization
    if current_applicant.workflow_state == "background_check_authorized"
      redirect_to confirmation_applicants_path
    end
  end

  def permitted_params
    %i(email first_name last_name phone phone_type region)
  end
end
