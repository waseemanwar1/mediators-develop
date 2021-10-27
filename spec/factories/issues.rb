FactoryBot.define do
  factory :issue do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    party_id { create(:party).id }
    title { "Title" }
    description { "Description" }
    resolution_title { "Resolution Title" }
    resolution_description { "Resolution Description" }
    mediators_notes_title { "Notes Title" }
    mediators_notes_description { "Notes Description" }
    agreement { "Agreement" }
  end
end
