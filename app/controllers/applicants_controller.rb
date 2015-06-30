class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end
end
