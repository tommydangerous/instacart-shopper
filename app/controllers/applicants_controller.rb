class ApplicantsController < ApplicationController
  include Sessionable

  before_action :require_login,
                only: %i(background background_authorize confirmation)
  before_action :require_logout, only: %i(create new)
  before_action :check_background_authorization,
                only: %i(background background_authorize)

  def background
  end

  def background_authorize
    current_applicant.update_next_workflow_state
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

  def new
    @applicant = Applicant.new
  end

  private

  def check_background_authorization
    if current_applicant.workflow_state == "background_check_authorized"
      redirect_to root_path
    end
  end

  def permitted_params
    %i(email first_name last_name phone phone_type region)
  end
end
