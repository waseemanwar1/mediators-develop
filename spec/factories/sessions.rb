FactoryBot.define do
  factory :session do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    party_id { create(:party).id }
    name { "Name" }
    due_date{  Date.today }
    time_start { Time.now }
    time_finish { Time.now + 1.hour }
    session_type { "Online" }
    location { "Location" }
    tags { ["Tag 1", "Tag 2"] }
    rate_type { "Hourly" }
    rate { 1000 }
  end
end
