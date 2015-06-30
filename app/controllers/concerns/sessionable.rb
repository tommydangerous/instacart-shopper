module Sessionable
  extend ActiveSupport::Concern

  include SessionsHelper

  def log_in(applicant)
    session[:applicant_email] = applicant.email
  end

  def log_out
    session.delete(:applicant_email)
    @current_applicant = nil
  end

  def logged_in?
    !current_applicant.nil?
  end

  def require_login
    redirect_to(new_applicant_path) unless logged_in?
  end

  def require_logout
    redirect_to(root_path) if logged_in?
  end
end
