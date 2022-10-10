FactoryBot.define do
  factory :micropost, class: Micropost do
    user
    content { 'Some sample test' }
  end
end
