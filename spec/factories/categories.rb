FactoryBot.define do
    factory :category do
        title { Faker::GameOfThrones.character}
    end
end
