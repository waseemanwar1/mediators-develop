FactoryBot.define do
  factory :admin_user do
    email { "test@example.com" }
    password { "example1234" }
    password_confirmation { "example1234" }

    trait :empty_email do
      email {""}
    end

    trait :empty_password do
      password {""}
    end

    trait :empty_password_confirmation do
      password_confirmation {""}
    end

    trait :wrong_email do
      email { "wrong@example.com" }
    end
  end
end
