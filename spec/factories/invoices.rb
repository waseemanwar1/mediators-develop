FactoryBot.define do
  factory :invoice do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    party_id { create(:party).id }
    name { "Name" }
    time { Time.now }
    amount { 1000 }
    date { Date.today }
    due_date { Date.today }
    status { "Paid" }
  end
end
