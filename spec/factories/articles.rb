FactoryBot.define do
    factory :article do
        title { Faker::GameOfThrones.character }
        content { Faker::StrangerThings.quote}
        category { create(:category)}
    end
end
