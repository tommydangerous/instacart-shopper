require "faker"

def create_applicants(hash, dates)
  hash.each do |key, value|
    value.times do
      applicant = Applicant.new
      applicant.first_name = Faker::Name.name
      applicant.last_name = Faker::Name.name
      applicant.email = "#{SecureRandom.uuid}@gmail.com"
      applicant.phone = Faker::PhoneNumber.cell_phone
      applicant.phone_type = Applicant::PHONE_TYPES.sample
      applicant.region = Applicant::REGIONS.sample
      applicant.workflow_state = key.to_s
      applicant.save!
      applicant.update! created_at: dates.sample.to_datetime
    end
  end
end

week1 = (1..7).to_a.map { |i| "2014-12-#{i}" }
week2 = (8..14).to_a.map { |i| "2014-12-#{i}" }
week3 = (15..21).to_a.map { |i| "2014-12-#{i}" }
week4 = (22..28).to_a.map { |i| "2014-12-#{i}" }

create_applicants({
  applied: 100,
  quiz_started: 50,
  quiz_completed: 20,
  onboarding_requested: 10,
  onboarding_completed: 5,
  hired: 1
}, week1)

create_applicants({
  applied: 200,
  quiz_started: 75,
  quiz_completed: 50,
  onboarding_requested: 20,
  onboarding_completed: 10,
  hired: 5
}, week2)

create_applicants({
  applied: 70,
  quiz_started: 20,
  quiz_completed: 10,
  onboarding_requested: 0,
  onboarding_completed: 0,
  hired: 0
}, week3)

create_applicants({
  applied: 40,
  quiz_started: 20,
  quiz_completed: 15,
  onboarding_requested: 5,
  onboarding_completed: 1,
  hired: 1
}, week4)
