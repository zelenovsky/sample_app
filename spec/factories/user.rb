FactoryBot.define do
  factory :user do
    name { 'Artem Factory' }
    email { 'artem@example.com' }
    password { 'password' }
  end
end
