FactoryBot.define do
  factory :message do
    admin_user_id { create(:admin_user).id }
    case_id { create(:case).id }
    party_id { create(:party).id }
    subject { "Subject" }
    sent_at { DateTime.now }
    content { "Content" }
    from { "From" }
    to { "To" }
  end
end
