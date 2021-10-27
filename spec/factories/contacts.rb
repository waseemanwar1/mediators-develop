FactoryBot.define do
  factory :contact do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    party_id { create(:party).id }
    first_name { "First Name" }
    last_name { " Last Name" }
    contact_type { "Wife" }
    email { "email@example.com" }
    title { "Title" }
    company { "Company" }
    phone { "Phone" }
    address { "Address" }
    notes { "Notes" }
    street { "Street" }
    city { "City" }
    state { "State" }
    zip_code { "Zip Code" }
    country { "Country" }
    tags { ["Tag 1", "Tag 2"] }
  end
end
