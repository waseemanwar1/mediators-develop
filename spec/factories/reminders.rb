FactoryBot.define do
  factory :reminder do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    party_id { create(:party).id }
    name { "Name" }
    description { "Description" }
    priority { "Important" }
    due_date { Date.today }
    contact_id { create(:contact).id }
    status { "Active" }
  end
end
