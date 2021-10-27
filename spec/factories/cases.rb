FactoryBot.define do
  factory :case do
    admin_user_id { create(:admin_user).id }
    program { "Program" }
    name { "Name" }
    description { "Description" }
    tags { ["Tag 1", "Tag 2"] }
  end
end
