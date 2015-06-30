class Applicant < ActiveRecord::Base
  PHONE_TYPES = [
    "iPhone 6/6 Plus",
    "iPhone 6s/6s Plus",
    "iPhone 5/5S",
    "iPhone 4/4S",
    "iPhone 3G/3GS",
    "Android 4.0+ (less than 2 years old)",
    "Android 2.2/2.3 (over 2 years old)",
    "Windows Phone",
    "Blackberry",
    "Other"
  ].freeze
  REGIONS = [
    "San Francisco Bay Area",
    "Chicago",
    "Boston NYC",
    "Toronto",
    "Berlin",
    "Delhi",
  ].freeze
  WORKFLOW_STATES = %w(
    applied
    background_check_authorized
    quiz_started
    quiz_completed
    onboarding_requested
    onboarding_completed
    hired
    rejected
  ).freeze

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :phone_type
  validates_presence_of :region
  validates_presence_of :workflow_state

  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :phone

  before_validation :initial_workflow_state, on: :create

  def update_next_workflow_state
    current_index = WORKFLOW_STATES.index workflow_state
    if current_index == WORKFLOW_STATES.size - 1
      return
    end
    index = current_index ? current_index + 1 : 0
    update workflow_state: WORKFLOW_STATES[index]
  end

  private

  def initial_workflow_state
    self.workflow_state = WORKFLOW_STATES.first
  end
end
