FactoryBot.define do
    factory :article do
        title { Faker::GameOfThrones.character }
        association :category
        content { Faker::StrangerThings.quote}
    end
end
