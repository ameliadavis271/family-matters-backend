FactoryBot.define do
    factory :event do
        sequence :name do |n|
            "Name #{n}"
        end
        sequence :description do |n|
            "Description #{n}"
        end
        sequence :date do |n|
            "Date #{n}"
        end
        sequence :time do |n|
            "Time #{n}"
        end

        trait :invalid do
            name { nil }
        end
    end
end