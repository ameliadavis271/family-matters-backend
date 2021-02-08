FactoryBot.define do 
    factory :family do
        sequence :name do |n|
            "FamilyName #{n}"
        end
        sequence :family_id do |n|
            "family_id #{n}"
        end
    end
end