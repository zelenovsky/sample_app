FactoryBot.define do
  trait :skip_validate do
    to_create { |instance| instance.save(validate: false) }
  end

  factory :user do
    name { 'Artem Factory' }
    email { 'artem@example.com' }
    password { 'password' }
  end

  factory :another_user, class: User do
    name { 'Vladimir Factory' }
    email { 'vladimir@example.com' }
    password { 'password' }
  end

  factory :invalid_user, traits: [:skip_validate], class: User do
    name { '' }
    email { 'foo@invalid' }
    password { 'foo' }
  end

  factory :faker_user, class: User do
    name { FFaker::Name.name }
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.password }
  end
end
