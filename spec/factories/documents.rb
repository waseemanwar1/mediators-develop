FactoryBot.define do
  factory :document do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    file_name { "File Name" }
    description { "Description" }
    date { Date.today + 1.day }
    author { "Author" }
  end
end
