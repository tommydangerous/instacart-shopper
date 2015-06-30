module SessionsHelper
  def current_applicant
    @current_applicant ||= Applicant.find_by(email: session[:applicant_email])
  end

  def logged_in?
    !current_applicant.nil?
  end
end
