FactoryBot.define do
    factory :article do
        title { Faker::GameOfThrones.character }
        category nil
        text { Faker::StrangerThings.quote}
    end
end
