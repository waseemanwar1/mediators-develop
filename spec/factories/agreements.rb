FactoryBot.define do
  factory :agreement do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    name { "Name" }
    content { "Content" }
  end
end
