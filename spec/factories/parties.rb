FactoryBot.define do
  factory :party do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    first_name { "First Name" }
    last_name { "Last Name" }
    title { "Title" }
    company { "Conpany" }
    address { "Address" }
    notes { "Notes" }
    email { "email@example.com" }
    phone { "0000000000" }
    street { "Street" }
    city { "City" }
    state { "State" }
    zip_code { "Zip Code" }
    country { "Country" }
    tags { ["Tag 1", "Tag 2"] }
  end
end
